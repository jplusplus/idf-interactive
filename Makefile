run:
	coffee app.coffee

install:
	npm install

ra2013:
	./export ra2013-bu
	./export ra2013-energies-positif
	./export ra2013-magazine
	./export ra2013-opendata
	./export ra2013-tourisme
	./export ra2013-transports


# EOF
