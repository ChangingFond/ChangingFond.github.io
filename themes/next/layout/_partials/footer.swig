<div class="copyright" >
  {% set current = date(Date.now(), "YYYY") %}
  &copy; {% if theme.since and theme.since != current %} {{ theme.since }} - {% endif %}
  <span itemprop="copyrightYear">{{ current }}</span>
  <span class="with-love">
    <i class="fa fa-{{ theme.authoricon }}"></i>
  </span>
  <span class="author" itemprop="copyrightHolder">{{ config.author }}</span>
  <span class="author" itemprop="copyrightHolder"></span>
</div>

{% if theme.copyright %}
<div class="powered-by">
  皖ICP备 16015215号
</div>

<div class="theme-info">
  NexT
</div>
{% endif %}
