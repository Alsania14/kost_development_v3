<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-success">
        <h5 class="modal-title text-light" id="exampleModalLabel">@yield('judul')</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        @yield('isi')
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>