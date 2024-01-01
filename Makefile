.PHONY: all clean
all: AM2D.zip

AM2D.zip: AM2D.app
	zip -r $@ AM2D.app

clean:
	-  rm AM2D.zip
