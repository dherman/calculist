PUBLISHED_DIRS = blog feeds tags
PUBLISHED_FILES = sitemap.txt *.html

.PHONY: preview build publish

preview:
	raco frog -bp

build:
	raco frog -b

publish:
	rm -rf _build
	mkdir _build
	mv $(PUBLISHED_DIRS) $(PUBLISHED_FILES) _build/
	git checkout gh-pages
	rm -rf $(PUBLISHED_DIRS)
	mv _build/* ./
	rmdir _build
	git status --porcelain | fgrep '??' | awk '{ print $2; }' | grep -E '^(blog|feeds|tags)/' | xargs git add
	git commit -a -m 'new post'
	git push
	git checkout master
