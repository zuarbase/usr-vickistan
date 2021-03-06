# Instructions for Zuar's `mkdocs-material` Documentation

This describes how to use Zuar's `mkdocs-material` documentation framework to
automatically create *public* documentation from a repo in Zuar's github organization.
Note the use of the word *public* -- if you follow the Quickstart below, whatever is
created will be publicly accessible. Don't worry; `mkdocs-material` can be use to create
private documentation as well.

## Quickstart

In a hurry to create some *public* documentation with Markdown?

1. [Use this template](https://github.com/zuarbase/mkdocs-template)
   to create a new repository in the Zuar organization.  Never created a repository from
   a template repository before?  [Here's how](
   https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-repository-from-a-template#creating-a-repository-from-a-template).

   Let's assume your name is Steve and you wanted to create a repo for your personal
   documentation stash, and that you named your repo `usr-steve`.

1. On your local system, clone your newly created repo:
   ```
   git clone git@github.com:zuarbase/usr-steve.git
   ```
   
1. Create some sample content:
   ```
   cd usr-steve
   printf "# Example Content\n\nfoo bar"  > docs/index.md
   ```
   
1. Pull the Docker image for `mkdocs-markdown`:
   ```
   make pull
   ```
   You only need to do this once.

1. View your documentation:
   ```
   make docs
   ```
   In your browser, navigate to [http://0.0.0.0:8000/](http://0.0.0.0:8000/) and view
   your work.
   
1. If you use an editor to modify your documentation, each time you save a file, the
   view in the browser will be updated to reflect your changes.

1. At this point, you have built documentation locally, but your work has not been
   committed to your repo, it has not been pushed to github, and the HTML version has
   not been published.
   
	Let's commit your changes and push them to github:
	```
	git add docs
	git commit -m'added example documentation'
	git push
	```
   
1. When your repo is pushed to github, a workflow is automatically run that builds the
   HTML version of your documents and publishes them as GitHub Pages.  In 30 seconds to
   a few minutes, Steve's documentation will be publicly viewable at
   [https://zuarbase.github.io/usr-steve/](https://zuarbase.github.io/usr-steve/).
   
   The documentation generated by this repo is publicly viewable at
   [https://zuarbase.github.io/mkdocs-template/](https://zuarbase.github.io/mkdocs-template/).


## Private Documentation

You want to create documentation with MM, but you don't want it to be public?  You can
still start with this repo as a template.  Once you have it locally, run:
```
cd <your-repo-name>
git rm .github
git commit -m'disable automatic publication of documentation'
git push
```
This disables the MM workflow and nothing will be published anywhere.

You can continue to develop your documentation locally and view it locally, as described
above.  If have have another location or web server to which you want your content
published, it's simple:
```
make build
```

Your HTML, CSS, and Javascript will be saved in `<your-repo-name>/site/`.  Simply
`rsync`, `scp`, or otherwise copy the contents of the `site` directory to your desired
destination.

## The Details

[`MkDocs`](https://www.mkdocs.org/) and [`Material for MkDocs`](
https://squidfunk.github.io/mkdocs-material/) are tools that allow one to author
attractive, well-organized, and well-presented documentation by creating Markdown
files.  Writing simple Markdown in text files with any editor allow content creators to
focus on content -- not fighting with frustratingly slow WYSIWIG single-page apps that
think they know more about what you are doing than you do.

Raw Markdown documents (files) are easy to read without any processing.  Typically,
however, Markdown files are processed to create documents in HTML, PDF, and other
formats.  MkDocs and Material for MkDocs (hereinafter referred to as MM) do a
spectacular job of translation.

Because Material for MkDocs is an extension to
MkDocs, documentation for the former should always take precedence over the latter.

MkDocs uses [Python
Markdown](https://python-markdown.github.io/) and [Python Markdown Extensions](
https://python-markdown.github.io/extensions/).
Material for MkDocs uses the same Python Markdown (confusingly) along with a different
[Python Markdown Extensions](
https://squidfunk.github.io/mkdocs-material/setup/extensions/python-markdown-extensions/
).  Material for MkDoc's Python Markdown Extensions are actually based on [PyMdown
Extensions](https://facelessuser.github.io/pymdown-extensions/).

Zuar has created a [fork](
https://github.com/zuarbase/mkdocs-material) of `mkdocs-material` that contains
customizations necessary for producing our internal and external documentation.  This
has been packaged as a Docker image that can be used as a [GitHub workflow](
https://github.com/zuarbase/mkdocs-deploy-gh-pages). 

Material for Markdown and the `gh-pages` workflow have been combined in this template to
automatically process and publish Markdown using Zuar's forked Material for Markdown.
