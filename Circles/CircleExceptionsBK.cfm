<!-- Button trigger circle modal-->
<button type="button" class="btn btn-sm btn-secondary" data-toggle="modal" onClick="getBookMembers()"
  data-target="#modalCircle">Except</button>

<!-- Modal: modalCircle -->
<div class="modal fade" id="modalCircle" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
  aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header">
        <h4 class="modal-title" id="myCircleLabel">Choose who can see this book:</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
        </button>
      </div>
      <!--Body-->
      <div class="modal-body" ID="MemDiv">

        <!--- List of people in selected circle goes in this modal --->

      </div>
      <!--Footer-->
      <div class="modal-footer">
        <button type="button" class="btn btn-outline-secondary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<!-- Modal: modalCircle -->