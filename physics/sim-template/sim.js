// Created By: Justin Meiners (2016)
var TIME_PER_FRAME = 16; //this equates to 60 fps

var g_canvas = document.getElementById("main-canvas");
var g_ctx = g_canvas.getContext("2d");

var g_width = 640;
var g_height = 480;

var g_loop = setInterval(sim_loop, TIME_PER_FRAME);


function Rocket() {
    this.x = g_width / 2;
    this.y = g_height * 0.9;

    this.mass = 2;

    this.vy = 0.0;

    this.radius = 4.0;
    this.length = 20.0;
    this.fuel = 100;
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



function sim_clear_canvas()
{
  g_ctx.fillStyle = '#d0e7f9';

  g_ctx.beginPath();
  g_ctx.rect(0, 0, g_width, g_height);
  g_ctx.closePath();

  g_ctx.fill();
}


function sim_update()
{
    if (g_rocket.fuel > 0) {
        g_rocket.vy += 2.1 / g_rocket.mass;

        g_rocket.fuel -= 1;
    }
    g_rocket.vy -= 0.981;

    g_rocket.y -= g_rocket.vy;
}

function sim_draw()
{
    draw_rocket(g_rocket);
}

function draw_rocket(rocket)
{
    g_ctx.strokeStyle = "#FF0000";
    g_ctx.beginPath();
    g_ctx.rect(rocket.x - rocket.radius / 2, rocket.y - rocket.length / 2, rocket.radius, rocket.length);
    g_ctx.closePath();
    g_ctx.stroke();
}
