#!/usr/bin/env node
# Script utility to create an interactive slider's configuration file (as JSON)

# Usage:
#   coffee create_conf <images folder> [-o <output file.json>]
# node dependencies 
fs      = require('fs')
# other dependencies (devDependencies in package.json)
program = require('commander')
_       = require('underscore')

program
    .version('0.0.1')
    .option('-d, --dir [path]', 'Path to input images folder')
    .option('-n, --name [name]', 'Name of this interactive app')
    .parse(process.argv)

class ConfigurationBuilder

    constructor: (@inputDir, @name="Default")->
        @baseImgDir = "/img/#{@name.toLowerCase()}"
        @steps =
            0:
                "no-index": true
                "no-title": true
                spots: [
                        "class": "app-title",
                        "title": "Île-de-France",
                        "sub-title": "#{@name}",
                        "top": "81.6666%",
                        "left": "2.234%"
                    ,
                        "width": 270,
                        "height": 275,
                        "class": "launcher",
                        "href": "#step=1",
                        "top": "56.1666%",
                        "left": "49.8936%",
                        "origin": "center"
                    ,
                        "class": "legend",
                        "background": "/img/common/howto_pic_lancez.png",
                        "height": 22,
                        "left": "2.1276%",
                        "top": "2.6666%",
                        "sub-title": "Lancez l’application"
                    ,
                        "class": "legend",
                        "background": "/img/common/howto_pic_suivant.png",
                        "height": 20,
                        "left": "2.0212%",
                        "top": "7.5%",
                        "sub-title": "Passez d’une page à l’autre"
                    ,
                        "class": "legend",
                        "background": "/img/common/howto-pic_chapitres.png",
                        "height": 45,
                        "left": "2.1276%",
                        "top": "12%",
                        "sub-title": "Sélectionnez directement<br />un chapitre"
                ]



    listDir: =>
        fs.readdirSync @inputDir

    build: =>
        for file in @listDir()
            matches = file.match(/(\d+)/g)
            if matches? and matches.length > 0
                [step_nb, image_nb] = matches
                step_nb = parseInt step_nb
                @steps[step_nb] ?=
                    spots: []
                    name: ""

                @steps[step_nb].spots.push 
                    left: "#{image_nb or 0}%"
                    top:  "#{image_nb or 0}%"
                    picture:
                        src: "#{@baseImgDir}/#{file}"
                        alt: ""
        conf = steps: _.map @steps, (v,k)-> v
        console.log JSON.stringify conf

dir = program.dir 
unless dir
    throw new Error('Input folder option is require (-d, --dir)')

builder = new ConfigurationBuilder(dir, program.name)
builder.build()
