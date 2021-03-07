# Building documentation

## Requirements

- [Pandoc](https://pandoc.org/)

## Building

Open `docs` directory and run following command in terminal `pandoc database.md functions/*.md procedures/*.md tables/*.md triggers/*.md views/*.md -o documentation.docx -V lang=pl --reference-doc=custom-reference.docx`
