# Abr

Abr is a gem for performance test with ab (apache bench).

## Installation
Install it yourself as:

    $ gem install abr

## Usage 
Make text and write ab command into it.

input_file.txt
```$xslt
ab -n 1 -c 1 https://google.com/
```

And then, pass as an option to this abr command.

```
abr test -i=input_file.txt
```

Finally, you got a result file which name is `result.csv`.

Or, you can specify result file name using `-o` option.


```
abr test -i=input_file.txt -o=specified_result_file.csv
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

