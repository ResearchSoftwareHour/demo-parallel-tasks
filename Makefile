INPUTS = $(wildcard *.jpg)

all: $(patsubst %.jpg,result/%.dat,$(INPUTS))

result/%.dat: %.jpg
	convert $< -paint 5 $@
