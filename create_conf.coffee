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
    .parse(process.argv)

class ConfigurationBuilder

    constructor: (@inputDir, @out)->
        @steps = {}

    listDir: =>
        fs.readdirSync @inputDir

    build: =>
        for file in @listDir()
            matches = file.match(/(\d+)/)
            if matches? and matches.length is 2
                [step_nb, image_nb] = matches
                step_nb = parseInt step_nb
                @steps[step_nb]  = @steps[step_nb]
                @steps[step_nb] ?=
                    spots: []
                    name: ""

                @steps[step_nb].spots.push 
                    left: "#{image_nb}%"
                    top:  "#{image_nb}%"
                    picture:
                        src: file
                        alt: ""
        conf = steps: _.map @steps, (v,k)-> v
        console.log JSON.stringify conf

dir = program.dir 
unless dir
    throw new Error('Input folder option is require (-d, --dir)')


builder = new ConfigurationBuilder(dir, program.out)
builder.build()
