// Created By: Justin Meiners (2016)
var TIME_PER_FRAME = 16; //this equates to 60 fps

var g_canvas = document.getElementById("main-canvas");
var g_ctx = g_canvas.getContext("2d");

var g_width = g_canvas.width;
var g_height = g_canvas.height;

var g_loop = setInterval(sim_loop, TIME_PER_FRAME);


function Rocket() {
    this.x = g_width / 2;
    this.y = 0;

    this.mass = 1.0;

    this.vy = 0.0;

    this.gas = 3.0;

    this.radius = 20.0;
    this.length = 40.0;
}

var g_rocket = new Rocket();

function sim_loop()
{
  sim_clear_canvas();

  sim_update();
  sim_draw();
}

function sim_start()
{

}

function Controller() {
    this.integral = 0;
    this.set = 200;

    this.k1 = 0.4;
    this.k2 = 1.2;
    this.k3 = 0.05;
}

function clamp(t, min, max) {
    return Math.min(Math.max(t, min), max);
}

Controller.prototype.getChange = function(x, x_prime, dt) {
    const e = this.set - x;
    this.integral += clamp(e, -3.5, 3.5) * dt;
    const out = this.k1 * e + this.k2 * -x_prime + this.k3 * this.integral;
    return out;
};


function sim_clear_canvas()
{
  g_ctx.fillStyle = '#d0e7f9';

  g_ctx.beginPath();
  g_ctx.rect(0, 0, g_width, g_height);
  g_ctx.closePath();

  g_ctx.fill();
}


var control = new Controller();

function sim_update() {
    const dt = 1.0 / TIME_PER_FRAME;
    const a = g_rocket.gas / g_rocket.mass - 0.981;

    g_rocket.vy += a * dt;
    g_rocket.y += g_rocket.vy * dt;

    g_rocket.gas = control.getChange(g_rocket.y, g_rocket.vy, dt);
    g_rocket.gas = clamp(g_rocket.gas, 0.0, 3.5);
    console.log(g_rocket.vy, g_rocket.gas);
    control.set += 1.0 * dt;
}

function sim_draw()
{
    draw_rocket(g_rocket);
    draw_line(control);
}

function draw_line(control)
{
    g_ctx.strokeStyle = '#00FF00';
    g_ctx.beginPath();
    g_ctx.moveTo(0.0, g_height - control.set);
    g_ctx.lineTo(g_width, g_height - control.set);
    g_ctx.closePath();
    g_ctx.stroke();
}

function draw_rocket(rocket)
{
    g_ctx.fillStyle = "#FF0000";
    g_ctx.beginPath();
    g_ctx.rect(rocket.x - rocket.radius / 2, g_height - (rocket.y + rocket.length / 2), rocket.radius, rocket.length);
    g_ctx.closePath();
    g_ctx.fill();

    if (g_rocket.gas > 0.01) {
        g_ctx.fillStyle = "#FFFF00";
        g_ctx.beginPath();
        g_ctx.rect(rocket.x - 4, g_height - (rocket.y - rocket.length / 2), 8, 16);
        g_ctx.closePath();
        g_ctx.fill();
    }
}
