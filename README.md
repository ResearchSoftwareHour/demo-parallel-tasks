# demo-parallel-tasks

Example used to demonstrate running tasks in parallel.

Image is in public domain and taken from https://en.wikipedia.org/wiki/Automation.


### Preparation

```bash
$ mkdir -p result
$ export MAGICK_THREAD_LIMIT=1
$ convert 01.jpg -paint 5 result/01.jpg
```

The `-paint 5` can be increased for longer runs and more
"rough painting". The `export MAGICK_THREAD_LIMIT=1` is important
to avoid that Imagemagick itself runs on several threads.

Links created with:

```bash
for number in $(seq -f %02g 2 10); do
    ln -s 01.jpg ${number}.jpg
done
```


### Using Makefile

See the [Makefile](Makefile).


### Using a shell loop

Running one after another:

```bash
for file in *.jpg; do
    convert ${file} -paint 5 result/${file}
done
```

Run in batches of four:

```bash
counter=0
for file in *.jpg; do
    echo starting converting ${file}
    convert ${file} -paint 5 result/${file} &
    counter=$(( counter + 1 ))
    [ $(( ${counter} % 4 )) -eq 0 ] && wait
done
wait
```


### xargs can run in parallel

```bash
$ find * -maxdepth 0 -name "*.jpg" | xargs      -I _ convert _ -paint 5 result/_
$ find * -maxdepth 0 -name "*.jpg" | xargs -P 4 -I _ convert _ -paint 5 result/_
```


### Using GNU parallel

```bash
$ find * -maxdepth 0 -name "*.jpg" | parallel 'convert {} -paint 5 result/{}'
```

- Thanks to [Ashwin Vishnu](https://github.com/ashwinvis) for showing me this!
- It also has an interesting / peculiar way of enforcing
  [citations](https://www.gnu.org/software/parallel/parallel_design.html#Citation-notice)
  (but this did not work for me).
