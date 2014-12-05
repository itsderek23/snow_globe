# Snow Globe!

Returns `true	` if it's snowing and false otherwise. 

## Usage

<pre>
$ chmod 755 is_it_snowing.rb 
$ ./is_it_snowing.rb 
$ false
</pre>

## Testing

To simulate `true`:

`DATE="2014-11-23-14" ./is_it_snowing.rb`

To simulate `false`:

`DATE="2014-12-04-14" ./is_it_snowing.rb`

## Raspberry Pi 

To toggle a pin based on result of `is_it_snowing.rb`:

`$ sudo ruby snow_globe_controller.rb`

To see the LED turn on:

`$ sudo DATE="2014-11-23-14" ruby snow_globe_controller.rb`

