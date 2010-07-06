Return-Path: <antoine@7degrees.co.za>
From: Antoine van Gelder <antoine@7degrees.co.za>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Date: Tue, 6 Jul 2010 11:52:49 +0200
Message-Id: <C996A616-0036-4092-B2E3-23A34FB14B95@7degrees.co.za>
Mime-Version: 1.0 (Apple Message framework v1081)
Subject: [B.A.T.M.A.N.] The great #batdroid hackathon of July 2010
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.lists.open-mesh.org>
List-Unsubscribe: <https://lists.open-mesh.org/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.org/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Subscribe: <https://lists.open-mesh.org/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=subscribe>
To: village-telco-dev@googlegroups.com, The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
Cc: Steve Song <steve.song@shuttleworthfoundation.org>, Neels van der Westhuizen <neels@rossum.co.za>, Edwin Blake <edwin@cs.uct.ac.za>

Heya folks,

Over the weekend a team consisting of Tatenda Chipeperekwa, Veenesh =
Jeena, Zaheer Abrahams from the UCT Honors program as well as YoursTruly =
succeeded in writing an App which allows anyone with a rooted Android =
handset to connect to a B.A.T.M.A.N. mesh network.

Work began on Saturday morning by bringing up a simple mesh testbed =
consisting of a Mesh Potato, an Ubiquity NS2 and a Linksys WRT54GL. The =
rest of the day was spent manually configuring the test phones into =
AdHoc mode and bringing the batmand mesh routing daemon up on both a HTC =
Magic & a HTC Legend.=20

After working our way through the traditional hacker supper of pizza and =
soft drinks we started the hard work that would consume us for the rest =
of the weekend, namely writing an App which could:

  a) reliably=20
  b) on any Android handset

...take the phone in&out of AdHoc mode and start&stop the B.A.T.M.A.N. =
mesh routing daemon.

What complicates this is that by default the Android software =
distribution does not support AdHoc WiFi mode, to further complicate =
matters is that the process to force the phones into AdHoc mode differs =
for almost every different handset model!=20

OhNoes!!!

Fortunately the team of pure stupendous at =
http://code.google.com/p/android-wifi-tether/, by releasing their work =
under GPL3, have saved the collective posteriors of the community by =
having done a staggering amount of work developing the scripts & code =
which take away 99% of the pain from this process. If anyone is in a =
position to call shots on this, please do consider contributing a cash =
donation, filing some bugs or a bit of hacking time to the =
android-wifi-tether project because their work has been absolutely key =
to the team being able to bring B.A.T.M.A.N. up on Android in only a =
weekend instead of a month of hacking followed by months and months of =
testing and refinement.

The rest of the evening and the next day was spent writing the App =
front-end integrating the batmand daemon with the android-wifi-tether =
code, banging on user interface design, conspicuous caffeine consumption =
and general wizardry until, some time round eight'o'clock on Sunday =
evening all the pieces finally came together and the team were able to =
demonstrate a running B.A.T.D.R.O.I.D. on the mesh testbed!

The code from the weekend is available at:

  http://code.google.com/p/android-batdroid/

Downloadable binaries to follow.

There are also some photos from the weekend up at:
  =20
  http://www.flickr.com/photos/45478359@N06/sets/72157624433728942/

Finally, mad props to:

Neels from the Open Innovation Studio =
(http://www.bym.co.za/projects/open-innovation-studio/) for creating a =
beautiful space with stunning energy, amazing coffee and generously =
sharing it with us for the weekend.

Steve Song from VillageTelco (http://www.villagetelco.org) & =
Shuttleworth Fondation (http://www.shuttleworthfoundation.org) for the =
support that made the weekend possible.

 - antoine


--
http://7degrees.co.za
"Libr=E9 software for human education"



