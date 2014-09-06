.PHONY: clean_icons icons

ICONS = hint.ext verify.ext next.ext previous.ext reveal.ext reset.ext
ICON_OPTIONS = -quality 90 -density 100 -trim -bordercolor white -border 10x10 -transparent white
CONVERT_ICON = $(IMAGEMAGICK) $(ICON_OPTIONS)

icons: $(subst .ext,.png,$(ICONS))

$(subst .ext,.pdf,$(ICONS)): $$(subst pdf,tex,$$@)
	$(LATEX) $<

$(subst .ext,.png,$(ICONS)): $$(subst png,pdf,$$@)
	$(CONVERT_ICON) $< $@

clean_icons:
	rm -f $(subst .ext,.png,$(ICONS))
	rm -f $(subst .ext,.pdf,$(ICONS))
	rm -f $(subst .ext,.aux,$(ICONS))
	rm -f $(subst .ext,.log,$(ICONS))

