<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="x-ua-compatible" content="id=edge">
    <title>title</title>
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width, initial-scale=1">

  </head>
  <body>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

    <ul class="nav nav-tabs">
      <li class="active">
        <a href="cohort.jsp" data-tab-id="eros">EROs</a>
      </li>
      <li>
        <a href="/content/two.txt" data-tab-id="imports">Imports</a>
      </li>
      <li>
        <a href="/content/three.txt" data-tab-id="accounting">Accounting</a>
      </li>
    </ul>

    <div class="tab-content clear-fix">
      <div class="tab-pane active" id="eros">1</div>
      <div class="tab-pane" id="imports">2</div>
      <div class="tab-pane" id="accounting">3</div>
    </div>

    <script>
	  $(document).ready
      $('.nav-tabs').on('click', 'a', function(e) {
        e.preventDefault();

        var $this = $(this);
        var tab = $this.data('tab-id');
        var href = $this.attr('href');

        $('#' + tab).load(href);
        console.log({
          tab: tab,
          href: href
        });

      });
  </script>
  </body>
</html>