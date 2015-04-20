Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 20 Apr 2015 19:25:26 +0200
Message-ID: <2501143.u7vtLp5lMn@bentobox>
In-Reply-To: <2017856.ZSEBf5EYJq@bentobox>
References: <13114664.Eg4ODy7KEo@bentobox> <2017856.ZSEBf5EYJq@bentobox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart2669001.g6JRgPFQH0"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
	release
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
 <b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n/>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
 <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: b.a.t.m.a.n@lists.open-mesh.org

This is a multi-part message in MIME format.

--nextPart2669001.g6JRgPFQH0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday 17 April 2015 20:03:06 Sven Eckelmann wrote:
> On Friday 17 April 2015 18:32:45 Sven Eckelmann wrote:
> [...]
> 
> > Releases
> > ~~~~~~~~
> > 
> > I was also under the impression that no one really knew what will be
> > released and what version of the kernel tree it will be based on. How
> > about
> > changing the Release-todo (see attached image)
[...]

Attached is an updated version of this image. It now also includes the 
development of 3 Linux-Versions (4.x, 4.y, 4.z) like the version of the 
current development process which I've tried to update last weekend [1].

The solid part of a linux development line (final of 4.x to 4.y) is around 10 
weeks (it is more like 9 weeks since some releases). A scale for the time is 
not shown anywhere because this might change in the future.


Kind regards,
	Sven

[1] http://www.open-mesh.org/projects/batman-adv/wiki/Release-todo

--nextPart2669001.g6JRgPFQH0
Content-Disposition: inline; filename="release_scheduling-proposal.svg"
Content-Transfer-Encoding: quoted-printable
Content-Type: image/svg+xml; name="release_scheduling-proposal.svg"

<?xml version=3D"1.0" encoding=3D"UTF-8" standalone=3D"no"?>
<!-- Created with Inkscape (http://www.inkscape.org/) -->

<svg
   xmlns:dc=3D"http://purl.org/dc/elements/1.1/"
   xmlns:cc=3D"http://creativecommons.org/ns#"
   xmlns:rdf=3D"http://www.w3.org/1999/02/22-rdf-syntax-ns#"
   xmlns:svg=3D"http://www.w3.org/2000/svg"
   xmlns=3D"http://www.w3.org/2000/svg"
   xmlns:sodipodi=3D"http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd=
"
   xmlns:inkscape=3D"http://www.inkscape.org/namespaces/inkscape"
   width=3D"734.09003"
   height=3D"590.35999"
   id=3D"svg2"
   version=3D"1.1"
   inkscape:version=3D"0.48.5 r10040"
   sodipodi:docname=3D"release_scheduling-proposal.svg">
  <defs
     id=3D"defs4">
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM"
       style=3D"overflow:visible">
      <path
         id=3D"path3872"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Mend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Mend"
       style=3D"overflow:visible">
      <path
         id=3D"path3708"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.4,0,0,-0.4,-4,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lstart"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lstart"
       style=3D"overflow:visible">
      <path
         id=3D"path3699"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(0.8,0,0,0.8,10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lend"
       style=3D"overflow:visible">
      <path
         id=3D"path3702"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"StopL"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopL"
       style=3D"overflow:visible">
      <path
         id=3D"path3869"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.8,0.8)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       style=3D"overflow:visible"
       id=3D"DistanceStart"
       refX=3D"0"
       refY=3D"0"
       orient=3D"auto"
       inkscape:stockid=3D"DistanceStart">
      <g
         id=3D"g2300">
        <path
           style=3D"fill:none;stroke:#ffffff;stroke-width:1.14999998;st=
roke-linecap:square"
           d=3D"M 0,0 2,0"
           id=3D"path2306"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#000000;fill-rule:evenodd;stroke:none"
           d=3D"M 0,0 13,4 9,0 13,-4 0,0 z"
           id=3D"path2302"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-line=
cap:square"
           d=3D"M 0,-4 0,40"
           id=3D"path2304"
           inkscape:connector-curvature=3D"0" />
      </g>
    </marker>
    <inkscape:perspective
       sodipodi:type=3D"inkscape:persp3d"
       inkscape:vp_x=3D"0 : 526.18109 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_z=3D"744.09448 : 526.18109 : 1"
       inkscape:persp3d-origin=3D"372.04724 : 350.78739 : 1"
       id=3D"perspective10" />
    <inkscape:perspective
       id=3D"perspective2830"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective2852"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective2878"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective2903"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-1"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-9"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-7"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-6"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-4"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-93"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-5"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4552-61"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective4717"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5326"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <marker
       inkscape:stockid=3D"Arrow1Lstart"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lstart-3"
       style=3D"overflow:visible">
      <path
         id=3D"path3699-0"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(0.8,0,0,0.8,10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"StopL"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopL-4"
       style=3D"overflow:visible">
      <path
         id=3D"path3869-4"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.8,0.8)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <inkscape:perspective
       id=3D"perspective5375"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5375-3"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5461"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5461-7"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5461-4"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective5571"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective10911"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <marker
       inkscape:stockid=3D"StopL"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopL-4-5"
       style=3D"overflow:visible">
      <path
         id=3D"path3869-4-3"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.8,0.8)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lend-8"
       style=3D"overflow:visible">
      <path
         id=3D"path3702-8"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10919"
       style=3D"overflow:visible">
      <path
         id=3D"path10921"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10923"
       style=3D"overflow:visible">
      <path
         id=3D"path10925"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10927"
       style=3D"overflow:visible">
      <path
         id=3D"path10929"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10931"
       style=3D"overflow:visible">
      <path
         id=3D"path10933"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10935"
       style=3D"overflow:visible">
      <path
         id=3D"path10937"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10939"
       style=3D"overflow:visible">
      <path
         id=3D"path10941"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10943"
       style=3D"overflow:visible">
      <path
         id=3D"path10945"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10947"
       style=3D"overflow:visible">
      <path
         id=3D"path10949"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10951"
       style=3D"overflow:visible">
      <path
         id=3D"path10953"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10955"
       style=3D"overflow:visible">
      <path
         id=3D"path10957"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker10959"
       style=3D"overflow:visible">
      <path
         id=3D"path10961"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <inkscape:perspective
       id=3D"perspective11144"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lend-5"
       style=3D"overflow:visible">
      <path
         id=3D"path3702-4"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <inkscape:perspective
       id=3D"perspective11178"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <marker
       inkscape:stockid=3D"Arrow1Lend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Lend-89"
       style=3D"overflow:visible">
      <path
         id=3D"path3702-3"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <inkscape:perspective
       id=3D"perspective12140"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12169"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12194"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12229"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12278"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12308"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12341"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12472"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12472-7"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <inkscape:perspective
       id=3D"perspective12513"
       inkscape:persp3d-origin=3D"0.5 : 0.33333333 : 1"
       inkscape:vp_z=3D"1 : 0.5 : 1"
       inkscape:vp_y=3D"0 : 1000 : 0"
       inkscape:vp_x=3D"0 : 0.5 : 1"
       sodipodi:type=3D"inkscape:persp3d" />
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM-9"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3872-0"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Mend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Mend-0"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3708-8"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.4,0,0,-0.4,-4,0)" />
    </marker>
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM-8"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3872-5"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Mend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Mend-3"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3708-1"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.4,0,0,-0.4,-4,0)" />
    </marker>
    <marker
       inkscape:stockid=3D"Arrow1Mend"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"Arrow1Mend-6"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3708-7"
         d=3D"M 0,0 5,-5 -12.5,0 5,5 0,0 z"
         style=3D"fill-rule:evenodd;stroke:#000000;stroke-width:1pt;mar=
ker-start:none"
         transform=3D"matrix(-0.4,0,0,-0.4,-4,0)" />
    </marker>
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM-5"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3872-2"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)" />
    </marker>
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM-1"
       style=3D"overflow:visible">
      <path
         inkscape:connector-curvature=3D"0"
         id=3D"path3872-1"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)" />
    </marker>
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"StopM-7"
       style=3D"overflow:visible">
      <path
         id=3D"path3872-7"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)"
         inkscape:connector-curvature=3D"0" />
    </marker>
    <marker
       style=3D"overflow:visible"
       inkscape:stockid=3D"InfiniteLineEnd"
       id=3D"InfiniteLineEnd"
       refX=3D"0"
       refY=3D"0"
       orient=3D"auto">
      <g
         id=3D"g4944"
         style=3D"fill:#000000">
        <circle
           id=3D"circle4946"
           r=3D"0.80000001"
           cy=3D"0"
           cx=3D"3"
           sodipodi:cx=3D"3"
           sodipodi:cy=3D"0"
           sodipodi:rx=3D"0.80000001"
           sodipodi:ry=3D"0.80000001" />
        <circle
           id=3D"circle4948"
           r=3D"0.80000001"
           cy=3D"0"
           cx=3D"6.5"
           sodipodi:cx=3D"6.5"
           sodipodi:cy=3D"0"
           sodipodi:rx=3D"0.80000001"
           sodipodi:ry=3D"0.80000001" />
        <circle
           id=3D"circle4950"
           r=3D"0.80000001"
           cy=3D"0"
           cx=3D"10"
           sodipodi:cx=3D"10"
           sodipodi:cy=3D"0"
           sodipodi:rx=3D"0.80000001"
           sodipodi:ry=3D"0.80000001" />
      </g>
    </marker>
    <marker
       inkscape:stockid=3D"StopM"
       orient=3D"auto"
       refY=3D"0"
       refX=3D"0"
       id=3D"marker4747"
       style=3D"overflow:visible">
      <path
         id=3D"path4749"
         d=3D"M 0,5.65 0,-5.65"
         style=3D"fill:none;stroke:#000000;stroke-width:1pt"
         transform=3D"scale(0.4,0.4)"
         inkscape:connector-curvature=3D"0" />
    </marker>
  </defs>
  <sodipodi:namedview
     id=3D"base"
     pagecolor=3D"#ffffff"
     bordercolor=3D"#666666"
     borderopacity=3D"1.0"
     inkscape:pageopacity=3D"0.0"
     inkscape:pageshadow=3D"2"
     inkscape:zoom=3D"1.979899"
     inkscape:cx=3D"371.08651"
     inkscape:cy=3D"401.6015"
     inkscape:document-units=3D"px"
     inkscape:current-layer=3D"g12537"
     showgrid=3D"true"
     showguides=3D"true"
     inkscape:guide-bbox=3D"true"
     inkscape:window-width=3D"1920"
     inkscape:window-height=3D"1180"
     inkscape:window-x=3D"1917"
     inkscape:window-y=3D"-3"
     inkscape:window-maximized=3D"1"
     inkscape:snap-bbox=3D"false">
    <inkscape:grid
       type=3D"xygrid"
       id=3D"grid2816"
       empspacing=3D"5"
       visible=3D"true"
       enabled=3D"true"
       snapvisiblegridlinesonly=3D"true" />
  </sodipodi:namedview>
  <metadata
     id=3D"metadata7">
    <rdf:RDF>
      <cc:Work
         rdf:about=3D"">
        <dc:format>image/svg+xml</dc:format>
        <dc:type
           rdf:resource=3D"http://purl.org/dc/dcmitype/StillImage" />
        <dc:title />
      </cc:Work>
    </rdf:RDF>
  </metadata>
  <g
     inkscape:label=3D"Layer 1"
     inkscape:groupmode=3D"layer"
     id=3D"layer1"
     transform=3D"translate(0,-462.00117)">
    <g
       id=3D"g12358"
       transform=3D"translate(0,514.99966)">
      <g
         id=3D"g12537">
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#55604f;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"420"
           y=3D"222.3615"
           id=3D"text4530-3-8-4"><tspan
             sodipodi:role=3D"line"
             x=3D"420"
             y=3D"222.3615"
             id=3D"tspan12258-7-2">net-next.git for 4.z</tspan></text>
        <path
           style=3D"fill:#c9b729;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 50,362.36199 70,0 20,20.00001 -20,20 -70,-1e-5 c -2.3=
5702,0 -5,-2.64298 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -5,-2.64=
297 -5,-5 0,-2.35702 5,-2.64297 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.=
35702 5,-2.64297 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.35702 2.64298,-=
5 5,-5 z"
           id=3D"rect11204-8-9"
           sodipodi:nodetypes=3D"scccsssssssss"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#44a00f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 120,335.375 20,20 -20,20 c 0,0 148.33333,0 225,0 l 60=
,60 -20,20 265,-0.015 20,-19.98499 -20,-20 -115,0 c 0,0 8.19601,-5.6447=
9 10,-10 1.27561,-3.0796 0,-20 0,-20 l 5,0 -10,-10 -10,10 5,0 c 0,0 1.5=
7286,17.06108 0,20 -2.83551,5.2982 -15,10 -15,10 l -95,0 -40,-40 20,-20=
 -20,-20 z"
           transform=3D"translate(0,-52.99849)"
           id=3D"rect11204-8-8-3"
           inkscape:connector-curvature=3D"0"
           sodipodi:nodetypes=3D"ccccccccccscccccscccccc" />
        <path
           style=3D"fill:#ff6600;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 49.5625,282.37701 c -2.232491,0.299 -4.5625,2.79029 -=
4.5625,5 0,2.35703 5,2.64298 5,5 0,2.35703 -5,2.64298 -5,5 0,2.35703 5,=
2.64298 5,5 0,2.35703 -5,2.64298 -5,5 0,2.35703 5,2.64298 5,5 0,2.35702=
 -5,2.64298 -5,5 0,2.35702 2.64298,4.99999 5,5 l 30,0 60.17106,60.17106=
 L 120,402.362 l 265,10e-6 20.52821,-19.45678 L 385,362.37701 l -90,0 c=
 0,0 8.19601,-5.64479 10,-10 1.27561,-3.0796 0,-20 0,-20 l 5,0 -10,-10 =
-10,10 5,0 c 0,0 1.57286,17.06108 0,20 -2.83551,5.2982 -15,10 -15,10 l =
-65,0 c 0,0 8.19601,-5.64479 10,-10 1.27561,-3.0796 0,-20 0,-20 l 5,0 -=
10,-10 -10,10 5,0 c 0,0 1.57286,17.06108 0,20 -2.83551,5.2982 -15,10 -1=
5,10 l -40,-0.015 -40,-40 20,-20.00001 -20,-20 -50,0.015 -20,0 c -0.147=
331,0 -0.288667,-0.0199 -0.4375,0 z"
           id=3D"rect11204-8"
           inkscape:connector-curvature=3D"0"
           sodipodi:nodetypes=3D"csssssssscccccccscccccsccscccccscccccc=
sc" />
        <path
           style=3D"fill:#55604f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 385,282.362 20,20 -20,20 c 0,0 51.66667,0.015 80,0.01=
5 2.35702,0 5,-2.64298 5,-5 0,-2.35702 -5,-2.64298 -5,-5 0,-2.35702 5,-=
2.64298 5,-5 0,-2.35702 -5,-2.64298 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,=
-2.35702 -5,-2.64298 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -5,-5 =
-5,-5 z"
           id=3D"rect11204-2"
           inkscape:connector-curvature=3D"0"
           sodipodi:nodetypes=3D"ccccssssssscc" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"130"
           y=3D"-27.638512"
           id=3D"text4530"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532"
             x=3D"130"
             y=3D"-27.638512"
             style=3D"font-style:normal;font-variant:normal;font-weight=
:bold;font-stretch:normal;font-family:Verdana;-inkscape-font-specificat=
ion:Verdana Bold">net.git for 4.x</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:normal=
;writing-mode:tb-rl;fill:#000000;fill-opacity:1;stroke:none;font-family=
:Bitstream Vera Sans"
           x=3D"71.647949"
           y=3D"48.612427"
           id=3D"text4536"
           transform=3D"matrix(0,1,1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4538"
             x=3D"48.612427"
             y=3D"71.647949" /></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-140.36914"
           id=3D"text4540"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542"
             x=3D"32.361488"
             y=3D"-140.36914">rc1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-170.21094"
           id=3D"text4540-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"32.361488"
             y=3D"-170.21094"
             id=3D"tspan4572">rc2</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:italic;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Abyssinica SIL Italic"
           x=3D"32.361488"
           y=3D"-200.21094"
           id=3D"text4540-9"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"32.361488"
             y=3D"-200.21094"
             id=3D"tspan4641">rc3</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-230.36914"
           id=3D"text4540-91"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-7"
             x=3D"32.361488"
             y=3D"-230.36914">rc4</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-260.36914"
           id=3D"text4540-6"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-73"
             x=3D"32.361488"
             y=3D"-260.36914">rc5</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-290.21094"
           id=3D"text4540-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"32.361488"
             y=3D"-290.21094"
             id=3D"tspan4645">rc6</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-320.36914"
           id=3D"text4540-1"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"32.361488"
             y=3D"-320.36914"
             id=3D"tspan4662">rc7</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"32.361488"
           y=3D"-350.21094"
           id=3D"text4540-08"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-8"
             x=3D"32.361488"
             y=3D"-350.21094">rc8</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#000000;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"32.361488"
           y=3D"-380"
           id=3D"text4540-63"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-85"
             x=3D"32.361488"
             y=3D"-380">final</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"37.361488"
           y=3D"-505.19922"
           id=3D"text4540-98"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"37.361488"
             y=3D"-505.19922"
             id=3D"tspan4705">.1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"37.361488"
           y=3D"-525.04102"
           id=3D"text4540-98-1"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"37.361488"
             y=3D"-525.04102"
             id=3D"tspan4705-0">.2</tspan></text>
        <path
           style=3D"fill:#ff6600;stroke:#ff6600;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:none;marker-start:url(#StopM);marker-end:none;display:=
inline"
           d=3D"m 120,-17.638512 265,0"
           id=3D"path8194"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 145,27.361488 0,-45"
           id=3D"path8594"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 175,27.361488 0,-45"
           id=3D"path8795"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 205,27.361488 0,-45"
           id=3D"path8996"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 235,27.361488 0,-45"
           id=3D"path9197"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 265,27.361488 0,-45"
           id=3D"path9398"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 295,27.361488 0,-45"
           id=3D"path9599"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 325,27.361488 0,-45"
           id=3D"path9800"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend);display:inline"
           d=3D"m 355,27.361488 0,-45"
           id=3D"path10001"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 385,27.361488 0,-45"
           id=3D"path10202"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 510,32.361488 0,-45"
           id=3D"path10403"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 525,32.361488 0,-45"
           id=3D"path10604"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44aa00;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"394.63086"
           y=3D"97.361496"
           id=3D"text4530-3"><tspan
             sodipodi:role=3D"line"
             x=3D"394.63086"
             y=3D"97.361496"
             id=3D"tspan12258">net.git for 4.y</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:normal=
;writing-mode:tb-rl;fill:#000000;fill-opacity:1;stroke:none;font-family=
:Bitstream Vera Sans"
           x=3D"171.64795"
           y=3D"313.61243"
           id=3D"text4536-8"
           transform=3D"matrix(0,1,1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4538-9"
             x=3D"313.61243"
             y=3D"171.64795" /></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-405"
           id=3D"text4540-64"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-3"
             x=3D"157.3615"
             y=3D"-405">rc1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-434.8418"
           id=3D"text4540-0-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"157.3615"
             y=3D"-434.8418"
             id=3D"tspan4572-3">rc2</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:italic;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Abyssinica SIL Italic"
           x=3D"157.3615"
           y=3D"-464.8418"
           id=3D"text4540-9-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"157.3615"
             y=3D"-464.8418"
             id=3D"tspan4641-6">rc3</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-495"
           id=3D"text4540-91-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-7-4"
             x=3D"157.3615"
             y=3D"-495">rc4</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-525"
           id=3D"text4540-6-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-73-8"
             x=3D"157.3615"
             y=3D"-525">rc5</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-554.8418"
           id=3D"text4540-3-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"157.3615"
             y=3D"-554.8418"
             id=3D"tspan4645-9">rc6</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-585"
           id=3D"text4540-1-7"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"157.3615"
             y=3D"-585"
             id=3D"tspan4662-7">rc7</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"157.3615"
           y=3D"-614.8418"
           id=3D"text4540-08-6"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-8-4"
             x=3D"157.3615"
             y=3D"-614.8418">rc8</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#000000;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"157.3615"
           y=3D"-644.63086"
           id=3D"text4540-63-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-85-0"
             x=3D"157.3615"
             y=3D"-644.63086">final</tspan></text>
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 409.63086,152.36149 0,-45"
           id=3D"path8594-0"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 439.63086,152.36149 0,-45"
           id=3D"path8795-5"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 469.63086,152.36149 0,-45"
           id=3D"path8996-9"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 499.63086,152.36149 0,-45"
           id=3D"path9197-4"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 529.63086,152.36149 0,-45"
           id=3D"path9398-6"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 559.63086,152.36149 0,-45"
           id=3D"path9599-9"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 589.63086,152.36149 0,-45"
           id=3D"path9800-2"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend);display:inline"
           d=3D"m 619.63086,152.36149 0,-45"
           id=3D"path10001-2"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 649.63086,152.36149 0,-45"
           id=3D"path10202-4"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <rect
           style=3D"fill:#000000;fill-opacity:0;stroke:#a2a2a2;stroke-w=
idth:4;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none"
           id=3D"rect12268-6"
           width=3D"715"
           height=3D"234.99988"
           x=3D"10"
           y=3D"272.36218"
           ry=3D"15" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:14px;font-style:normal;font-weight:bold;t=
ext-align:end;writing-mode:lr-tb;text-anchor:end;fill:#a2a2a2;fill-opac=
ity:1;stroke:none;font-family:Bitstream Vera Sans;-inkscape-font-specif=
ication:Abyssinica SIL Bold"
           x=3D"237.36206"
           y=3D"-15"
           id=3D"text12292"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12294"
             x=3D"237.36206"
             y=3D"-15">Linux</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#ff6600;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"447.362"
           y=3D"-380"
           id=3D"text12296"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298"
             x=3D"447.362"
             y=3D"-380">2015.a</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:14px;font-style:normal;font-weight:bold;t=
ext-align:end;writing-mode:lr-tb;text-anchor:end;fill:#a2a2a2;fill-opac=
ity:1;stroke:none;font-family:Bitstream Vera Sans;-inkscape-font-specif=
ication:Abyssinica SIL Bold"
           x=3D"492.05347"
           y=3D"-15"
           id=3D"text12292-1"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12294-2"
             x=3D"492.05347"
             y=3D"-15">batman-adv</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44a00f;=
fill-opacity:0.94117647;stroke:none;font-family:Verdana;-inkscape-font-=
specification:Abyssinica SIL Bold"
           x=3D"447.362"
           y=3D"-645"
           id=3D"text12296-2-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298-5-0"
             x=3D"447.362"
             y=3D"-645">2015.b</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"245"
           y=3D"307.362"
           id=3D"text12157-5"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12159-0"
             x=3D"245"
             y=3D"307.362">master</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"245"
           y=3D"387.362"
           id=3D"text12157-0-6"><tspan
             sodipodi:role=3D"line"
             x=3D"245"
             y=3D"387.362"
             id=3D"tspan12217-4">maint</tspan></text>
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 385,362.36199 0,85"
           id=3D"path12130-1"
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-curvature=3D"0" />
        <path
           inkscape:connector-type=3D"polyline"
           id=3D"path12535"
           d=3D"M 384.63086,362.36199 385,62.361994"
           style=3D"fill:none;stroke:#000000;stroke-width:1.26131248;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.26131246, 5.04524986;stroke-dashoffset:0;displ=
ay:inline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"535"
           y=3D"387.362"
           id=3D"text12157-0-6-5"><tspan
             sodipodi:role=3D"line"
             x=3D"535"
             y=3D"387.362"
             id=3D"tspan12217-4-0">maint</tspan></text>
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 120,362.36199 0,84.99988"
           id=3D"path12130"
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#c9b729;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"447.362"
           y=3D"-115"
           id=3D"text12296-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298-9"
             x=3D"447.362"
             y=3D"-115">2014.z</tspan></text>
        <path
           style=3D"fill:none;stroke:#44aa00;stroke-width:3.45700002;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:3.457, 3.457;stroke-dashoffset:0;marker-start:ur=
l(#StopM);marker-end:none;display:inline"
           d=3D"m 145,107.3615 240,0"
           id=3D"path8194-4-5"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-type=3D"polyline"
           id=3D"path12533-6"
           d=3D"m 145,52.361493 0,55.000007"
           style=3D"fill:none;stroke:#44aa00;stroke-width:1.19299996;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.193, 1.193;stroke-dashoffset:0;display:inline"=

           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44aa00;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"155"
           y=3D"97.361496"
           id=3D"text4530-3-8"><tspan
             sodipodi:role=3D"line"
             x=3D"155"
             y=3D"97.361496"
             id=3D"tspan12258-7">net-next.git for 4.y</tspan></text>
        <path
           style=3D"fill:#ff6600;stroke:#ff6600;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:8, 4, 2, 4;stroke-dashoffset:0;marker-start:none;marke=
r-end:url(#Arrow1Mend);display:inline"
           d=3D"m 385,-17.638512 310,0"
           id=3D"path8194-1"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"440"
           y=3D"-27.638512"
           id=3D"text4530-0"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532-0"
             x=3D"440"
             y=3D"-27.638512"
             style=3D"font-style:normal;font-variant:normal;font-weight=
:bold;font-stretch:normal;font-family:Verdana;-inkscape-font-specificat=
ion:Verdana Bold">stable for 4.x.=CE=B1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44aa00;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"640"
           y=3D"97.361496"
           id=3D"text4530-3-3"><tspan
             sodipodi:role=3D"line"
             x=3D"640"
             y=3D"97.361496"
             id=3D"tspan12258-4">4.y</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"370"
           y=3D"-27.638512"
           id=3D"text4530-8"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532-7"
             x=3D"370"
             y=3D"-27.638512"
             style=3D"font-style:normal;font-variant:normal;font-weight=
:bold;font-stretch:normal;font-family:Verdana;-inkscape-font-specificat=
ion:Verdana Bold">4.x</tspan></text>
        <path
           style=3D"fill:#55604f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 385,282.34576 20,20 -20,20 c 0,0 148.33333,0.0312 225=
,0.0312 l 40,40 20,19.98454 -20,20.01546 45,0 c 2.35702,0 5,-2.64298 5,=
-5 0,-2.35702 -5,-2.64298 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -=
5,-2.64298 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -5,-2.64298 -5,-=
5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -2.64298,-5 -5,-5 l -5,0 -40,-4=
0 20,-20.03125 -20,-20 -265,0 z"
           id=3D"rect11204-2-6"
           inkscape:connector-curvature=3D"0"
           sodipodi:nodetypes=3D"cccccccssssssssscccccc" />
        <path
           style=3D"fill:#ff6600;stroke:#44aa00;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:8, 4, 2, 4;stroke-dashoffset:0;marker-start:none;marke=
r-end:url(#Arrow1Mend);display:inline"
           d=3D"m 650,107.3615 45,0"
           id=3D"path8194-1-0"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#ff6600;stroke:#44aa00;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:none;marker-start:url(#StopM);marker-end:none;display:=
inline"
           d=3D"m 385,107.3615 265,0"
           id=3D"path8194-8"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#ff6600;stroke-width:3.45700002;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:3.457, 3.457;stroke-dashoffset:0;marker-start:no=
ne;marker-end:none;display:inline"
           d=3D"m 45,-17.638512 75,0"
           id=3D"path8194-4-5-5"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#0fa070;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 650,282.362 45,0 c 2.35702,0 5,2.64298 5,5 0,2.35702 =
-5,2.64298 -5,5 0,2.35702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,2.3=
5702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,2.35702 5,2.64298 5,5 0,=
2.35702 -2.64298,5 -5,5 l -45,0 20,-20 z"
           id=3D"rect11204-2-88"
           sodipodi:nodetypes=3D"csssssssssccc"
           inkscape:connector-curvature=3D"0" />
        <path
           inkscape:connector-curvature=3D"0"
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 650,362.362 0,85"
           id=3D"path12130-4"
           sodipodi:nodetypes=3D"cc" />
        <path
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-type=3D"polyline"
           id=3D"path12533-9"
           d=3D"M 650,187.36199 650,362.362"
           style=3D"fill:none;stroke:#000000;stroke-width:1.19341624;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.19341629, 4.77366518;stroke-dashoffset:0;displ=
ay:inline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"535"
           y=3D"307.362"
           id=3D"text12157-5-8"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12159-0-2"
             x=3D"535"
             y=3D"307.362">master</tspan></text>
        <path
           style=3D"fill:none;stroke:#55604f;stroke-width:3.45700002;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:3.457, 3.457;stroke-dashoffset:0;marker-start:ur=
l(#StopM);marker-end:none;display:inline"
           d=3D"m 410,232.36187 240,0"
           id=3D"path8194-4-5-4"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-type=3D"polyline"
           id=3D"path12533-6-1"
           d=3D"m 410,177.362 0,55"
           style=3D"fill:none;stroke:#55604f;stroke-width:1.19299996;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.193, 1.193;stroke-dashoffset:0;display:inline"=

           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#55604f;stroke-width:3.45700002;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:none;marker-start:url(#StopM);marker-end:url(#In=
finiteLineEnd);display:inline"
           d=3D"m 650,232.362 10,-5.3e-4"
           id=3D"path8194-4-0"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <rect
           style=3D"fill:#000000;fill-opacity:0;stroke:#a2a2a2;stroke-w=
idth:4;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none"
           id=3D"rect12268-2"
           width=3D"715"
           height=3D"294.99945"
           x=3D"10"
           y=3D"-42.637943"
           ry=3D"15" />
      </g>
    </g>
  </g>
</svg>

--nextPart2669001.g6JRgPFQH0--

