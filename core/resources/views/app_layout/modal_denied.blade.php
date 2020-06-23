<div class="modal fade" id="modaldenied" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title text-light" id="exampleModalLabel">@yield('modal_denied_judul')</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body text-dark">
        @yield('modal_denied_isi')
      </div>
      <div class="modal-footer">
        <button type="button" class="btn bg-danger" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>