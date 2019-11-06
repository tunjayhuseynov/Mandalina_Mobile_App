@extends('layout.home')
@section('content')

@if(session()->has('message'))
<div class="alert alert-success">
    {{ session()->get('message') }}
</div>
@endif

<table id="movieList" class="table table-striped table-bordered responsive" style="width:100%">
    <thead>
        <tr>
            <th>Name</th>
            <th style="width: 60px">Id</th>
            <th style="width: 100px">Type</th>
            <th style="width: 100px">Episodes</th>
            <th style="width: 200px">Addition Date</th>
            <th style="width: 150px">Actions</th>
        </tr>
    </thead>
    <tbody>
@foreach ($data as $item)

        <tr>
            <td>{{$item['name']}}</td>
            <td>{{$item['id']}}</td>
            <td>{{$item['movieType']==1?"Movie":"Series"}}</td>
            <td>{{$item['movieType']==2?count($item['episodes'])." Episodes":""}}</td>
            <td>{{$item['addedDate']}}</td>
        <td><a target="_blank" href="{{url('/AdminPanelPinnme/edit/'.$item['id'])}}">Edit</a> ||
            <a onclick="return confirm('Do you really want to delete it?');" href="{{url('/AdminPanelPinnme/delete/'.$item['id'])}}">Delete</a> ||
            <a target="_blank" href="{{url('/AdminPanelPinnme/view/'.$item['id'])}}">View</a>
        </td>
        </tr>

@endforeach
</tbody>
</table>

<script>
$(document).ready(function() {
    $('#movieList').DataTable({
        responsive: true,
        dom: 'lBfrtip',
        buttons: [
                        {
                extend: 'excelHtml5',
                title: 'Movie List',
                exportOptions: {
                    columns: [ 0, 1, 2]
                }
            },
            {
                extend: 'pdfHtml5',
                title: 'Movie List',
                exportOptions: {
                    columns: [ 0, 1, 2]
                }
            },
     
        ],
        order: [[4,"desc"]],
    });
} );
</script>
@endsection
