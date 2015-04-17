Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 17 Apr 2015 18:32:45 +0200
Message-ID: <13114664.Eg4ODy7KEo@bentobox>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nextPart4073973.q7iOdBf9ul"
Content-Transfer-Encoding: 7Bit
Subject: [B.A.T.M.A.N.] [PATCH-next 0/6] Patches for batman-adv 2015.0
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
To: "b.a.t.m.a.n" <b.a.t.m.a.n@lists.open-mesh.org>

This is a multi-part message in MIME format.

--nextPart4073973.q7iOdBf9ul
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi,

I was told that batman-adv 2015.0 should be released based on patches which
are currently in Linux 4.1. I've checked the current state and it seems that
there are even patches in Linux 4.0 which aren't yet merged into the
out-of-tree module. And also patches of the Linux 4.1 kernel tree aren't
applied. The net-next merge window for Linux 4.1 is closed for this kernel but
Linus still gathers patches for it. This is also the reason why there are some
patches for batman-adv not yet in Linus tree but in David's net.git.
Interestingly, some of these patches were already merged in the out-of-tree
module - but not all.

This patchset is just to cleanup the current state of net.git. Sorry for all
the merge conflicts which may now happen with master and some patches on the
mailing list.


Included patches
~~~~~~~~~~~~~~~~

Patches which were missing:

 * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b7a8d756fb8080ab6ba9f4a9d4056a1056245fbc
 * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=b98fe24ca7d0effdd4c47a9f681d9e4f10442827
 * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=a54acb3a6f853e8394c4cb7b6a4d93c88f13eefd


Patches which are in batman-adv master but should be in this release:

 * http://git.open-mesh.org/batman-adv.git/commit/3f74f359cb7e96bbc68d62e1fc48b04b6efb4ca7


A patch which should never ever have existed in the first place (please
correct me when I've missed the actual problem):

 * http://git.open-mesh.org/linux-merge.git/commit/b53915310227cc9b029ba0fa5aae44e50a461f80


The weirdest commit is one which is in batman-adv next but can nowhere be
found in the kernel trees. It is already part of the release v2014.2.0:

 * http://git.open-mesh.org/batman-adv.git/commit/31f391475cc08724e96ab060ef4aa6503d11da8e
   (havent touched this commit because this is just too weird)


Releases
~~~~~~~~

I was also under the impression that no one really knew what will be released
and what version of the kernel tree it will be based on. How about changing
the Release-todo (see attached image)

 * maint branch is released as feature release 2015.a after linux 4.x
   is tagged
 * 2015.a.y branches are released on demand... most likely never
 * content of master becomes new maint after release

It is basically an old idea [1] with the branches renamed to keep "master" as
the main development branch (submission to David's net-next.git) and "maint" as
the branch which gathers bugfixes for net.git.

Kind regards,
	Sven


[1] https://lists.open-mesh.org/pipermail/b.a.t.m.a.n/2012-December/008719.html
--nextPart4073973.q7iOdBf9ul
Content-Disposition: attachment; filename="release_scheduling.svg"
Content-Transfer-Encoding: quoted-printable
Content-Type: image/svg+xml; name="release_scheduling.svg"

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
   height=3D"535.35999"
   id=3D"svg2"
   version=3D"1.1"
   inkscape:version=3D"0.48.5 r10040"
   sodipodi:docname=3D"release_scheduling.svg">
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
         transform=3D"scale(0.4,0.4)" />
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
         transform=3D"matrix(-0.4,0,0,-0.4,-4,0)" />
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
         transform=3D"matrix(0.8,0,0,0.8,10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"scale(0.8,0.8)" />
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
           id=3D"path2306" />
        <path
           style=3D"fill:#000000;fill-rule:evenodd;stroke:none"
           d=3D"M 0,0 13,4 9,0 13,-4 0,0 z"
           id=3D"path2302" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1;stroke-line=
cap:square"
           d=3D"M 0,-4 0,40"
           id=3D"path2304" />
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
         transform=3D"matrix(0.8,0,0,0.8,10,0)" />
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
         transform=3D"scale(0.8,0.8)" />
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
         transform=3D"scale(0.8,0.8)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
         transform=3D"matrix(-0.8,0,0,-0.8,-10,0)" />
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
  </defs>
  <sodipodi:namedview
     id=3D"base"
     pagecolor=3D"#ffffff"
     bordercolor=3D"#666666"
     borderopacity=3D"1.0"
     inkscape:pageopacity=3D"0.0"
     inkscape:pageshadow=3D"2"
     inkscape:zoom=3D"1.979899"
     inkscape:cx=3D"361.38691"
     inkscape:cy=3D"282.43768"
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
     transform=3D"translate(0,-517.00173)">
    <g
       id=3D"g12358"
       transform=3D"translate(0,514.99966)">
      <g
         id=3D"g12537">
        <path
           style=3D"fill:#c9b729;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 55,347.36206 110,0 0,40 -110,0 c -2.35702,0 -5,-2.642=
98 -5,-5 0,-2.35702 5,-2.64298 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.3=
5702 5,-2.64297 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.35702 5,-2.64297=
 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.35702 2.64298,-5 5,-5 z"
           id=3D"rect11204-8-9"
           sodipodi:nodetypes=3D"sccsssssssss"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#44a00f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"M 100.11683,282.36218 365,282.36206 l 0,40 -264.88317,1=
.2e-4 z"
           id=3D"rect11204-8-8-3"
           sodipodi:nodetypes=3D"ccccc"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#ff6600;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 54.88317,282.36206 45.11683,0 65,65 265,0 0,40 -265,0=
 -65,-65 -45.11683,0 c -2.35702,0 -5,-2.64298 -5,-5 0,-2.35702 5,-2.642=
98 5,-5 0,-2.35702 -5,-2.64297 -5,-5 0,-2.35702 5,-2.64297 5,-5 0,-2.35=
702 -5,-2.64297 -5,-5 0,-2.35702 5,-2.64297 5,-5 0,-2.35702 -5,-2.64297=
 -5,-5 0,-2.35702 2.64298,-5 5,-5 z"
           id=3D"rect11204-8"
           sodipodi:nodetypes=3D"sccccccsssssssss"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#55604f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 365,282.36206 120,0 c 2.35702,0 5,2.64298 5,5 0,2.357=
02 -5,2.64298 -5,5 0,2.35702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,=
2.35702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,2.35702 5,2.64298 5,5=
 0,2.35702 -2.64298,5 -5,5 l -120,0 z"
           id=3D"rect11204-2"
           sodipodi:nodetypes=3D"cssssssssscc"
           inkscape:connector-curvature=3D"0" />
        <rect
           style=3D"fill:#000000;fill-opacity:0;stroke:#a2a2a2;stroke-w=
idth:4;stroke-miterlimit:4;stroke-opacity:1;stroke-dasharray:none"
           id=3D"rect12268"
           width=3D"715"
           height=3D"240"
           x=3D"10"
           y=3D"12.362183"
           ry=3D"15" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"135"
           y=3D"27.362055"
           id=3D"text4530"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532"
             x=3D"135"
             y=3D"27.362055"
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
           x=3D"87.362053"
           y=3D"-145.36914"
           id=3D"text4540"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542"
             x=3D"87.362053"
             y=3D"-145.36914">rc1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-175.21094"
           id=3D"text4540-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"87.362053"
             y=3D"-175.21094"
             id=3D"tspan4572">rc2</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:italic;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Abyssinica SIL Italic"
           x=3D"87.362053"
           y=3D"-205.21094"
           id=3D"text4540-9"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"87.362053"
             y=3D"-205.21094"
             id=3D"tspan4641">rc3</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-235.36914"
           id=3D"text4540-91"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-7"
             x=3D"87.362053"
             y=3D"-235.36914">rc4</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-265.36914"
           id=3D"text4540-6"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-73"
             x=3D"87.362053"
             y=3D"-265.36914">rc5</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-295.21094"
           id=3D"text4540-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"87.362053"
             y=3D"-295.21094"
             id=3D"tspan4645">rc6</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-325.36914"
           id=3D"text4540-1"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"87.362053"
             y=3D"-325.36914"
             id=3D"tspan4662">rc7</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"87.362053"
           y=3D"-355.21094"
           id=3D"text4540-08"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-8"
             x=3D"87.362053"
             y=3D"-355.21094">rc8</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#000000;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"87.362053"
           y=3D"-385"
           id=3D"text4540-63"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-85"
             x=3D"87.362053"
             y=3D"-385">final</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"92.362053"
           y=3D"-510.19922"
           id=3D"text4540-98"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"92.362053"
             y=3D"-510.19922"
             id=3D"tspan4705">.1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"92.362053"
           y=3D"-530.04102"
           id=3D"text4540-98-1"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"92.362053"
             y=3D"-530.04102"
             id=3D"tspan4705-0">.2</tspan></text>
        <path
           style=3D"fill:#ff6600;stroke:#ff6600;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:none;marker-start:url(#StopM);marker-end:url(#Arrow1Me=
nd);display:inline"
           d=3D"m 125,37.362055 305,0"
           id=3D"path8194"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 150,82.362055 0,-45"
           id=3D"path8594"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 180,82.362055 0,-45"
           id=3D"path8795"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 210,82.362055 0,-45"
           id=3D"path8996"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 240,82.362055 0,-45"
           id=3D"path9197"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 270,82.362055 0,-45"
           id=3D"path9398"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 300,82.362055 0,-45"
           id=3D"path9599"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 330,82.362055 0,-45"
           id=3D"path9800"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend);display:inline"
           d=3D"m 360,82.362055 0,-45"
           id=3D"path10001"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 390,82.362055 0,-45"
           id=3D"path10202"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 515,87.362055 0,-45"
           id=3D"path10403"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 530,87.362055 0,-45"
           id=3D"path10604"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44aa00;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"399.63086"
           y=3D"152.36206"
           id=3D"text4530-3"><tspan
             sodipodi:role=3D"line"
             x=3D"399.63086"
             y=3D"152.36206"
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
           x=3D"212.36206"
           y=3D"-410"
           id=3D"text4540-64"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-3"
             x=3D"212.36206"
             y=3D"-410">rc1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-439.8418"
           id=3D"text4540-0-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"212.36206"
             y=3D"-439.8418"
             id=3D"tspan4572-3">rc2</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:italic;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Abyssinica SIL Italic"
           x=3D"212.36206"
           y=3D"-469.8418"
           id=3D"text4540-9-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"212.36206"
             y=3D"-469.8418"
             id=3D"tspan4641-6">rc3</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-500"
           id=3D"text4540-91-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-7-4"
             x=3D"212.36206"
             y=3D"-500">rc4</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-530"
           id=3D"text4540-6-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-73-8"
             x=3D"212.36206"
             y=3D"-530">rc5</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-559.8418"
           id=3D"text4540-3-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"212.36206"
             y=3D"-559.8418"
             id=3D"tspan4645-9">rc6</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-590"
           id=3D"text4540-1-7"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             x=3D"212.36206"
             y=3D"-590"
             id=3D"tspan4662-7">rc7</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;writing-mode:lr-tb;fill:#00000=
0;fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifi=
cation:Verdana"
           x=3D"212.36206"
           y=3D"-619.8418"
           id=3D"text4540-08-6"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-8-4"
             x=3D"212.36206"
             y=3D"-619.8418">rc8</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#000000;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"212.36206"
           y=3D"-649.63086"
           id=3D"text4540-63-3"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4542-85-0"
             x=3D"212.36206"
             y=3D"-649.63086">final</tspan></text>
        <path
           style=3D"fill:none;stroke:#44aa00;stroke-width:3.45713854;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:none;marker-start:url(#StopM);marker-end:url(#Ar=
row1Mend)"
           d=3D"m 389.63086,162.36205 310,0"
           id=3D"path8194-4"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 414.63086,207.36205 0,-45"
           id=3D"path8594-0"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 444.63086,207.36205 0,-45"
           id=3D"path8795-5"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 474.63086,207.36205 0,-45"
           id=3D"path8996-9"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 504.63086,207.36205 0,-45"
           id=3D"path9197-4"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 534.63086,207.36205 0,-45"
           id=3D"path9398-6"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 564.63086,207.36205 0,-45"
           id=3D"path9599-9"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 594.63086,207.36205 0,-45"
           id=3D"path9800-2"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend);display:inline"
           d=3D"m 624.63086,207.36205 0,-45"
           id=3D"path10001-2"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1;marker-end:url(#Arrow=
1Lend)"
           d=3D"m 654.63086,207.36205 0,-45"
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
           x=3D"235.07312"
           y=3D"-15"
           id=3D"text12292"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12294"
             x=3D"235.07312"
             y=3D"-15">Linux</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#ff6600;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"437.36206"
           y=3D"-384.63086"
           id=3D"text12296"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298"
             x=3D"437.36206"
             y=3D"-384.63086">2015.a</tspan></text>
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
           x=3D"437.36206"
           y=3D"-649.63086"
           id=3D"text12296-2-8"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298-5-0"
             x=3D"437.36206"
             y=3D"-649.63086">2015.b</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"250"
           y=3D"307.36206"
           id=3D"text12157-5"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12159-0"
             x=3D"250"
             y=3D"307.36206">master</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"250.14355"
           y=3D"372.36206"
           id=3D"text12157-0-6"><tspan
             sodipodi:role=3D"line"
             x=3D"250.14355"
             y=3D"372.36206"
             id=3D"tspan12217-4">maint</tspan></text>
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 389.61914,347.36204 0,85"
           id=3D"path12130-1"
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-curvature=3D"0" />
        <path
           style=3D"fill:#44a00f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 365,282.36206 65,65 265,0 0,40 -265,0 -65,-65 z"
           id=3D"rect11204-2-4"
           sodipodi:nodetypes=3D"ccccccc"
           inkscape:connector-curvature=3D"0" />
        <path
           inkscape:connector-type=3D"polyline"
           id=3D"path12535"
           d=3D"m 389.63086,347.36205 0,-175"
           style=3D"fill:none;stroke:#000000;stroke-width:1.26131248;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.26131246, 5.04524986;stroke-dashoffset:0"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:normal;font-stretch:normal;text-align:center;writing-mode=
:lr-tb;text-anchor:middle;fill:#000000;fill-opacity:1;stroke:none;font-=
family:Verdana;-inkscape-font-specification:Verdana"
           x=3D"540.20898"
           y=3D"372.36206"
           id=3D"text12157-0-6-5"><tspan
             sodipodi:role=3D"line"
             x=3D"540.20898"
             y=3D"372.36206"
             id=3D"tspan12217-4-0">maint</tspan></text>
        <path
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-type=3D"polyline"
           id=3D"path12533-9"
           d=3D"m 654.63086,242.36205 0,105.00001"
           style=3D"fill:none;stroke:#000000;stroke-width:1.19341624;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:1.19341629, 4.77366518;stroke-dashoffset:0;displ=
ay:inline"
           inkscape:connector-curvature=3D"0" />
        <path
           inkscape:connector-curvature=3D"0"
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 654.63086,347.36218 0,84.99987"
           id=3D"path12130-4"
           sodipodi:nodetypes=3D"cc" />
        <path
           style=3D"fill:none;stroke:#000000;stroke-width:1px;stroke-li=
necap:butt;stroke-linejoin:miter;stroke-opacity:1"
           d=3D"m 125,347.36218 0,84.99988"
           id=3D"path12130"
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#c9b729;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"437.36206"
           y=3D"-120"
           id=3D"text12296-0"
           transform=3D"matrix(0,1,-1,0,0,0)"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan12298-9"
             x=3D"437.36206"
             y=3D"-120">2014.z</tspan></text>
        <path
           style=3D"fill:none;stroke:#44aa00;stroke-width:3.45700002;st=
roke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opac=
ity:1;stroke-dasharray:3.457, 3.457;stroke-dashoffset:0;marker-start:ur=
l(#StopM);marker-end:none;display:inline"
           d=3D"m 150,162.36206 240,0"
           id=3D"path8194-4-5"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <path
           sodipodi:nodetypes=3D"cc"
           inkscape:connector-type=3D"polyline"
           id=3D"path12533-6"
           d=3D"m 150,107.36206 0,55"
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
           x=3D"160"
           y=3D"152.36206"
           id=3D"text4530-3-8"><tspan
             sodipodi:role=3D"line"
             x=3D"160"
             y=3D"152.36206"
             id=3D"tspan12258-7">net-next.git for 4.y</tspan></text>
        <path
           style=3D"fill:#ff6600;stroke:#ff6600;stroke-width:4;stroke-l=
inecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-opacity:1;=
stroke-dasharray:8,4,2,4;marker-end:url(#Arrow1Mend);display:inline;mar=
ker-start:none;stroke-dashoffset:0"
           d=3D"m 435,37.362055 265,0"
           id=3D"path8194-1"
           inkscape:connector-type=3D"polyline"
           inkscape:connector-curvature=3D"0" />
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"445"
           y=3D"27.362055"
           id=3D"text4530-0"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532-0"
             x=3D"445"
             y=3D"27.362055"
             style=3D"font-style:normal;font-variant:normal;font-weight=
:bold;font-stretch:normal;font-family:Verdana;-inkscape-font-specificat=
ion:Verdana Bold">stable for 4.x.=CE=B1</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-variant:norma=
l;font-weight:bold;font-stretch:normal;writing-mode:lr-tb;fill:#44aa00;=
fill-opacity:1;stroke:none;font-family:Verdana;-inkscape-font-specifica=
tion:Abyssinica SIL Bold"
           x=3D"645"
           y=3D"152.36206"
           id=3D"text4530-3-3"><tspan
             sodipodi:role=3D"line"
             x=3D"645"
             y=3D"152.36206"
             id=3D"tspan12258-4">4.y</tspan></text>
        <text
           xml:space=3D"preserve"
           style=3D"font-size:12px;font-style:normal;font-weight:bold;w=
riting-mode:lr-tb;fill:#ff6600;fill-opacity:1;stroke:none;font-family:B=
itstream Vera Sans;-inkscape-font-specification:Abyssinica SIL Bold"
           x=3D"375"
           y=3D"27.362055"
           id=3D"text4530-8"><tspan
             sodipodi:role=3D"line"
             id=3D"tspan4532-7"
             x=3D"375"
             y=3D"27.362055"
             style=3D"font-style:normal;font-variant:normal;font-weight=
:bold;font-stretch:normal;font-family:Verdana;-inkscape-font-specificat=
ion:Verdana Bold">4.x</tspan></text>
        <path
           style=3D"fill:#55604f;fill-opacity:1;stroke:#000000;stroke-w=
idth:1;stroke-miterlimit:4;stroke-opacity:0"
           d=3D"m 655,347.36206 40,0 c 2.35702,0 5,2.64298 5,5 0,2.3570=
2 -5,2.64298 -5,5 0,2.35702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,2=
.35702 5,2.64298 5,5 0,2.35702 -5,2.64298 -5,5 0,2.35702 5,2.64298 5,5 =
0,2.35702 -2.64298,5 -5,5 l 0,0 z"
           id=3D"rect11204-2-6"
           sodipodi:nodetypes=3D"cssssssssscc"
           inkscape:connector-curvature=3D"0" />
      </g>
    </g>
  </g>
</svg>

--nextPart4073973.q7iOdBf9ul--

