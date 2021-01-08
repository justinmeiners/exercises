(function () {

    // Physics Stuff
    // ================

   function heat_step_c(t_prev, t_curr, t_next, total_mass, dt) {
        // finite difference version of heat equation
        // This is differential operator notation (such as Calculus on Manifolds.)
        // D_{t} T = a ( D_{x}^{2} T)

        var a = 500.0 / (4182 * total_mass); // some factor of specific heat and mass
        var change = a * ((t_prev + t_next) / 2.0 - t_curr);
        return change * dt;
    };

    function solar_energy_j(area_m, dt) {
        // Energy from sun
        // 137 mili-watts / cm^2 
        // https://www.grc.nasa.gov/www/k-12/Numbers/Math/Mathematical_Thinking/sun12.htm
        return 0.137 * area_m * 1000.0 * dt;
    };

   function temp_from_energy_c(energy, mass) {
        // Specific heat
        // 4182 Joules/Kg * C
        // Q = cm dT
        // http://hyperphysics.phy-astr.gsu.edu/hbase/thermo/spht.html#c1
        return energy / (4182 * mass);
    };

    function volume_of_pipe_m(radius_m, length_m) {
        // volume of cylinder
        return Math.PI * radius_m * radius_m * length_m;
    };

    function mass_of_water_kg(radius_m, length_m) {
        // density of water 997 kg/m^3
        return volume_of_pipe_m(radius_m, length_m) * 997;
    };


    function velocity_step_c(t_prev, t_curr, velocity_ms, move_mass_kg, pipe_mass_kg, dt) {
        // area * velocity is constant (noncompressable)
        // so we have the same inflow and outflow mass
        // just calculate what propoprtion is the "new" water
        // and which was the "old" water.
       
        var remove = velocity_ms * move_mass_kg * dt;

        var original_mass_ratio = 1.0 - remove / pipe_mass_kg;
        return original_mass_ratio * t_curr + (1.0 - original_mass_ratio) * t_prev;
    };

    function pipe_surface_area_m(radius_m, length_m) {
        // surface area of cycliner
        // I suppose the solar panel could have
        // mirrors to reflect sun all around
        return radius_m * 2 * Math.PI * length_m;
    };

    // UTILITIES
    // ==============
   
    // JS doesn't do mod correctly
    // https://stackoverflow.com/questions/4467539/javascript-modulo-gives-a-negative-result-for-negative-numbers
    function mod(n, m) {
        return ((n % m) + m) % m;
    }


    // SIMULATION
    // ==============
 
    var PIPE_NORMAL = 1;
    var PIPE_PUMP = 2;
    var PIPE_SOLAR = 3;

    // keep state out of data description
    //
    function Pipe(l, r, opt_kind) {
        this.length = l;
        this.radius = r;
        this.kind = opt_kind || PIPE_NORMAL;
    };

    // pure function old state, environment -> new state
    function integrate_state(state, pipes, pump_velocity, sun_power, dt) {
        var pump_mass = 0.4;

        var N = pipes.length;
        var new_state = new Array(N);


        for (var i = 0; i < N; ++i) {
            var prev_i = mod(i - 1, N);
            var next_i = mod(i + 1, N);
            var pipe = pipes[i];

            // this gives us a new temperature
            var total_mass = mass_of_water_kg(pipe.radius, pipe.length);
            var new_T = velocity_step_c(state[prev_i], state[i], pump_velocity, pump_mass, total_mass, dt);

            // these give us additional changes in temperature
            new_T += heat_step_c(state[prev_i], state[i], state[next_i], total_mass, dt); 

            if (pipe.kind === PIPE_SOLAR) {
                var area = pipe_surface_area_m(pipe.radius, pipe.length);
                var added_joules = sun_power * solar_energy_j(area, dt);
                new_T += temp_from_energy_c(added_joules, total_mass);
            }
 
            new_state[i] = new_T;
        };


        console.log(new_state);

        return new_state;
    };

    function Simulator() {
        this.canvas = document.getElementById('main-canvas');
        this.ctx = this.canvas.getContext('2d', { alpha: false });
        this.state = [];

        this.timeLabel = document.getElementById('current-time');

        document.getElementById('time-speed').onchange = (evt) => {
            this.dt = parseFloat(evt.target.value);
        };

        document.getElementById('pump-velocity').onchange = (evt) => {
            this.pump_velocity = parseFloat(evt.target.value);
        };

        //document.getElementById('sun').onchange = (evt) => {
        //    this.sun_power = parseFloat(evt.target.value);
        //};

        document.getElementById('reset').onclick = (evt) => {
            this.reset();
        };


        var w = 0.05
        var l = 2.2;

        this.pipes = [
            new Pipe(25.0, w, PIPE_SOLAR),
            new Pipe(l, w),
            new Pipe(l, w),
            new Pipe(l, w),
            new Pipe(l, w, PIPE_PUMP),
            new Pipe(l, w),
            new Pipe(l, w),
            // tank
            new Pipe(3.0, 0.3),
            // other
            new Pipe(l, w),
            new Pipe(l, w),
            new Pipe(l, w),
            new Pipe(l, w),
            new Pipe(l, w),
        ];

        this.reset();
    };

    Simulator.prototype.step = function() {
        this.state = integrate_state(this.state, this.pipes, this.pump_velocity, this.sun_power, this.dt);
        this.time += this.dt;

        var hottest = this.state.reduce((max, x) => Math.max(max, x));
        this.timeLabel.innerText = (this.time / 60.0).toFixed(1) + ' minutes. ' + hottest.toFixed(1.0) + ' (C) hottest temperature';
    };


    Simulator.prototype.reset = function() {
        // starting temperature 8 degrees celcius
        var inital_temp = 8.0;
        this.state = this.pipes.map(x => inital_temp);

        this.time = 0.0;

        this.dt = 1.0;
        this.pump_velocity = 0.0;
        this.sun_power = 20.0;

        //document.getElementById('sun').value = this.sun_power.toString();
        document.getElementById('time-speed').value = this.dt.toString();
        document.getElementById('pump-velocity').value = this.pump_velocity.toString();

    };
    

    var g_sim = new Simulator();

    setInterval(function() {
        g_sim.step();
        draw_sim(g_sim);
    }, 60);


    // RENDERING
    // ===========================

    function clear_canvas(ctx, canvas) {
        ctx.fillStyle = '#e4ceaf';
        ctx.beginPath();
        ctx.rect(0, 0, canvas.width, canvas.height);
        ctx.closePath();
        return ctx.fill();
    };

    function draw_sim(sim) {
        clear_canvas(sim.ctx, sim.canvas);

        var total_length = sim.pipes.reduce((acc, pipe) => acc + pipe.length, 0.0);
        var angle = 0.0;

        sim.pipes.forEach((p, i) => {
            var angle_width = 2.0 * Math.PI  * (p.length / total_length);
            draw_pipe(sim, angle, angle + angle_width, p,  sim.state[i], total_length);
            angle += angle_width;
        });

    };

    function color_for_temp(temp) {
        var t = Math.max(0.0, Math.min((temp - 12.0) / 8.0, 100.0));

        var color = [t * 255.0, 0.0, (1-t) * 255.0];
        return 'rgb(' + color.join(',') + ')';
    };

    function draw_pipe(sim, start_angle, end_angle, pipe, temp, total_length) {
        var ctx = sim.ctx;
        var x = sim.canvas.width / 2.0;
        var y = sim.canvas.height / 2.0;

        var big_radius = Math.min(x, y) / 2.0;
        var radius =  big_radius * (pipe.radius / total_length * 80.0);

        ctx.beginPath();
        ctx.arc(x, y, big_radius - radius, start_angle, end_angle, false);
        ctx.arc(x, y, big_radius + radius, end_angle, start_angle, true);
        ctx.closePath();

        ctx.fillStyle = color_for_temp(temp);
        ctx.fill()

        if (pipe.kind === PIPE_SOLAR) {
            ctx.strokeStyle = '#FFFF00';
            ctx.lineWidth = 4.0;
        } else {
            ctx.strokeStyle = '#DDDDDD';
            ctx.lineWidth = 1.0;
        }

        ctx.beginPath();
        ctx.arc(x, y, big_radius - radius, start_angle, end_angle, false);
        ctx.arc(x, y, big_radius + radius, end_angle, start_angle, true);
        ctx.closePath();


        ctx.stroke();

    };


})();
