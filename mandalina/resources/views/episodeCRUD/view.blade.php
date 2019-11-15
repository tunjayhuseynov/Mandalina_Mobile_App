@extends('layout.home')
@section('content')


<div class="container-fluid">
        <div class="row">
                <div class="col-3">
                        <div class="box text-center" style="padding: 0!important">
                                <label>Cover Image: </label> <br>
                                <img style="max-width: 100%" src="{{$data[0]->image}}">
                        </div>
                </div>

                <div class="col-3">
                        <div class="box text-center">
                                <label>Name: </label>
                                <h4>{{$data[0]->name}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Season: </label>
                                <h4>{{$data[0]->season}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Number: </label>
                                <h4>{{$data[0]->number}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Addition Date: </label>
                                <h4>{{$data[0]->addedDate}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Duration: </label>
                                <h4>{{$data[0]->airtime}}</h4>
                        </div>
                        <div class="box text-center">
                                <label>Series Name: </label>
                                <h4>
                                    {{$data[2]}}
                                </h4>
                        </div>
                </div>
                <div class="col-6">
                        <div class="box text-center" style="padding: 15px 15px;">
                                <label>Description: </label>
                                <h5 style="text-align: justify">{{$data[0]->summary}}</h5>
                        </div>
                        <div class="box text-center" style="padding: 15px 15px;">
                                        <label>Episode Link: </label>
                                        <h5 style="text-align: center">
                                        <a target="_blank" href="{{{$data[1].$data[0]->url}}}">{{$data[1].$data[0]->url}}</a>
                                        </h5>
                                </div>

                </div>
        </div>
</div>

@endsection