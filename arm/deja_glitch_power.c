
//
// Copyright (c) Deja vu Security
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in   
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//
// Authors:
//   Michael Eddington (mike@dejavusecurity.com)
//

#include "io.h"

#define DEJA_GLITCH_POWER_POWER   0
#define DEJA_GLITCH_POWER_RUN     0

#define DEJA_GLITCH_POWER_SIZE    0
// READ or WRITE iteration step (default 1)
#define DEJA_GLITCH_POWER_STEP    1
// READ status flags
#define DEJA_GLITCH_POWER_STATUS  2


int __attribute__ ((unused)) deja_glitch_power_set_port_run_i(unsigned char run_port)
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_RUN;

    io_fpga_register_write(reg, run_port);

    return 0;
}

int __attribute__ ((unused)) deja_glitch_power_get_port_run_i()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_RUN;

    io_fpga_register_write(reg, 0);
    return io_fpga_register_read(reg);
}

int __attribute__ ((unused)) deja_glitch_power_set_port_power_o(unsigned char power_port)
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_POWER;

    io_fpga_register_write(reg, power_port);

    return 0;
}

int __attribute__ ((unused)) deja_glitch_power_get_port_power_o()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_POWER;

    io_fpga_register_write(reg, 0);
    return io_fpga_register_read(reg);
}

int __attribute__ ((unused)) deja_glitch_power_set_size(unsigned char size)
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_SIZE;

    io_fpga_register_write((15 << 4) | DEJA_GLITCH_POWER_SIZE, size);
    return 0;
}

int __attribute__ ((unused)) deja_glitch_power_get_size()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_SIZE;

    io_fpga_register_write(reg, 0);
    return io_fpga_register_read(reg);
}

int __attribute__ ((unused)) deja_glitch_power_set_step(unsigned char step)
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_STEP;

    return io_fpga_register_write(reg, step);
}

int __attribute__ ((unused)) deja_glitch_power_get_step()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_SIZE;

    io_fpga_register_write(reg, 0);
    return io_fpga_register_read(reg);
}

int __attribute__ ((unused)) deja_glitch_power_get_finished()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_STATUS;

    io_fpga_register_write(reg, val);
    return io_fpga_register_read(reg);
}

int __attribute__ ((unused)) deja_glitch_reset()
{
    unsigned char reg = (15 << 4) | DEJA_GLITCH_POWER_STATUS;
    unsigned char val = 1;

    io_fpga_register_write(reg, val);

    return 0;
}

int __attribute__ ((unused)) deja_glitch_power_cli(int , portCHAR **)
{
  if(!strcmp(argv[0], "help"))
  {
    printf(
"Power Glitching Module\n"
"Copyright (c) Deja vu Security\n"
"Michael Eddington\n\n"

"Syntax: gp <command> [argument]\n\n"

"  set_port_run_i [PORT]   - Configure run input port\n"
"  get_port_run_i          - Configure run input port\n"
"  set_port_power_o [PORT] - Configure power output port\n"
"  get_port_power_o        - Configure power output port\n"
"  set_size [SIZE]         - Set the size of the power glitch in clock cycles\n"
"  get_size                - Get the size of the power glitch in clock cycles\n"
"  set_step [STEP]         - Set the step size (iterator step) in clock cycles\n"
"  get_Step                - Get the step size (iterator step) in clock cycles\n"
"  get_finished            - Get the is finished value\n"
"  reset                   - Reset module\n\n"
    );
  }
  
  else if(!strcmp(argv[0], "set_port_run_i"))
  {
    unsigned char val = strtol(argv[1], NULL, 10);

    deja_glitch_power_set_port_run_i(val);
  }
  else if(!strcmp(argv[0], "get_port_run_i"))
  {
    printf("Run port is %d.\n", deja_glitch_power_get_port_run_i();
  }
  
  else if(!strcmp(argv[0], "set_port_power_o"))
  {
    unsigned char val = strtol(argv[1], NULL, 10);

    deja_glitch_power_set_power_o(val);
  }
  else if(!strcmp(argv[0], "get_port_power_o"))
  {
    printf("Power port is %d.\n", deja_glitch_power_get_power_o());
  }

  else if(!strcmp(argv[0], "set_size"))
  {
    unsigned char val = strtol(argv[1], NULL, 10);

    deja_glitch_power_set_size(val);
  }
  else if(!strcmp(argv[0], "get_size"))
  {
    printf("Size is %d.\n", deja_glitch_power_get_size());
  }
  else if(!strcmp(argv[0], "set_step"))
  {
    unsigned char val = strtol(argv[1], NULL, 10);

    deja_glitch_power_set_step(val);
  }
  else if(!strcmp(argv[0], "get_step"))
  {
    printf("Step is set to %d.\n", deja_glitch_power_get_step());
  }
  else if(!strcmp(argv[0], "get_finished"))
  {
    unsigned char val = 0;

    val = deja_glitch_power_get_finished();

    if(val[0])
      printf("Test has not finished yet.\n");
    else
      printf("Test has completed.\n");
  }
  else if(!strcmp(argv[0], "reset"))
  {
    deja_glitch_power_reset();
  }
  else
  {
    printf("Error, unknown command.  Say 'help' for assistance.\n");
    return -1;
  }

  return 0;
}



// end
