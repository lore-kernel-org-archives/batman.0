Message-ID: <499494DE.1070304@gmail.com>
Date: Thu, 12 Feb 2009 15:30:06 -0600
From: Tim LePes <luvdownbabylon@gmail.com>
MIME-Version: 1.0
References: <mailman.134.1234470500.960.b.a.t.m.a.n@open-mesh.net>
In-Reply-To: <mailman.134.1234470500.960.b.a.t.m.a.n@open-mesh.net>
Content-Type: multipart/mixed; boundary="------------000801080404000506010204"
Subject: Re: [B.A.T.M.A.N.] B.A.T.M.A.N Digest, Vol 26, Issue 7
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: b.a.t.m.a.n@open-mesh.net

This is a multi-part message in MIME format.
--------------000801080404000506010204
Content-Type: multipart/alternative;
 boundary="------------030001010109030301050502"


--------------030001010109030301050502
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Feb 2009 03:26:13 +0700, Outback Dingo
<outbackdingo@gmail.com> wrote:
> yupp got me kinda curious also, though you can definatley do stable
> long distance with wifi and the right antennas, what advantage really
> does wimax provide, if any. Overall id be very surprised if it was
> even really adopted. there are very few wimax capable laptops even now
> let alone desktops.
>
> On Fri, Feb 13, 2009 at 3:05 AM, Simon Wunderlich
> <simon.wunderlich@s2003.tu-chemnitz.de
> <mailto:simon.wunderlich@s2003.tu-chemnitz.de>> wrote:
>
>     Hello Tim,
>
>     unfortunately i have no experience with WiMAX, but as far as i know=
:
>
>      * WiMAX is not license-free like WiFi (means you need to BUY a
>     license,
>       at least in germany)
>      * where is the technical advantage of WiMAX over WiFi?
>       Sure, the advertisements say "50 km or 108 MBit/s", but they
>     don't say
>       "both at the same time".
>       You can reach this with WiFi as well (with the right antennas
>     and setup).
>
>     So my question is: Where do you see the advantages in WiMAX over Wi=
Fi?
>
>     I don't know if there is some mesh technology available (as in
>     implemented) for WiMAX (as far as i know 802.16d?) or if there are
>     adhoc-like modes available to let routing protocols like BATMAN wor=
k.
>
>     If you know more about WiMAX meshing i'd be very interested to
>     hear. :)
>
>     best regards
>            Simon
>

I understand you can get good range with WiFi using directional
antennae, parabolic antennae, "cantennas", etc.  I *have* thought about
directional antennas for back-haul, but the project idea was geared
toward emergency workers being able to set up a network as simply as
possible.  So I have been leaning toward a good solution to work with
omni-directional antennas.  No "aiming" needed... plug and play would be
ideal.  With directional antennas it would take a little more work.  But
may be a better solution in the end.  Nothing is set in stone here.

I was going with WiMAX because, to my understanding, I could get a far,
far greater range using omni-directional antennas than I could with
WiFi.  I do understand that the data rates fall off with distance.  I am
not interested, here, in providing typical municipal wireless solutions
where the users are going to be working with rich content a lot.  I want
to be able to set up a communications network that can help rescue
workers get access to logistics and co-ordination web pages.

Mainly, I am interested in implementing SAHANA on this network.  From
their web site, "Sahana is a Free and Open Source Disaster Management
system. It is a web based collaboration tool that addresses the common
coordination problems during a disaster from finding missing people,
managing aid, managing volunteers, tracking camps effectively between
Government groups, the civil society (NGOs) and the victims
themselves."  You can find more info at http://www.sahana.lk/ or
http://en.wikipedia.org/wiki/Sahana_FOSS_Disaster_Management_System if
you would like to check it out further.  So the primary application I
want to support is simply a web app on a server, and have it run
reasonably well over the mesh.  I am not going for VoIP or streaming
video, so the top-end bandwidth is not my main goal.  Distance is.  Ease
of set-up is.  But, of course, I will eventually have to do real-world
testing to see if the throughput would suffice.  If I were to do
directional antennas, I would look to WiFi or Microwave just as readily
as WiMAX.

Now as a secondary function, this disaster-relief network could also
support access out to the wider web, and it would be nice for rescue
workers in the Red Cross tent or what have some PCs connected to my mesh
node, using it as an AP into the mesh and on to the web.  The idea is
not, even then, to support video conferencing or bittorrents.  Email to
friends and family.  Government and NGO resource web pages.  Etc.

The dev board I have is a 400MHz Freescale MPC5200B PowerPC SoC - based
unit called the EFIKA 5200B from Genesi.  See
http://www.genesi-usa.com/efika for details.  I am going to outfit it
with a PCI to MiniPCI adapter and should be able to put two miniPCI
cards on it.  Now here, I will note that I have only been able to find a
mini-PCI EXPRESS adapter (from Intel, and it also supports WiFi).=20
Intel's "Echo Peak"...   "Intel=AE WiMAX/WiFi Link 5150(512ANXMMWG) is a
1X2 MIMO (Multiple Input, Multiple Output) 1x2 (one transmit chain, two
receive chains) PCIe Minicard supporting IEEE 802.16e and 802.11a/b/g/n
wireless network adapters that operate in the 2.4 GHz and 5.0 GHz
spectra for WiFi and 2.5 GHz for WiMAX."

802.16d tends to be good for fixed stations.  And the idea is that these
nodes will pretty much stay put once set up.  802.16e is largely being
touted for it's mobile network features... and it is coming to the US.=20
Clearwire wireless broadband (802.11d methinks) is already deployed in
Nashville.  Clearwire is now backed by Sprint and others.  Sprint's XOHM
is also picking up steam.  This is an 802.16e service that is one "4G"
route.  Though for the cell companies, LTE is also on the horizon.=20
Sprint are supposed to be carrying the Nokia N810 tablet now with WiMax
in it.  More and more MIDs, netbooks, smart phones, and eventually
laptops and such will be coming with 802.16e chipsets.  Especially since
major cell carriers have been investing in this technology.  Sprint has
infrastructure already.  I am not so interested in the mobile aspects of
802.16e though.  I am interested in the MIMO technology support, however.=


Licensing issues I will get to later.  There is unlicensed spectrum
available here in the US.  But as this is geared toward emergency use, I
imagine that there will be considerations regarding spectrum use for
such an application that may be favorable.  More research is in order
here, I agree.  At one point Genesi told me I had the Australian
government interested in my project, but at the time I had nothing to
show for it yet so I didn't pursue anything with them.

Granted, this is a learn-as-you-go project for me.  I have Debian
running on the device, but that's about it so far.  Well, it also runs
Apache.  I have to get some hardware to be able to do anything
constructive.  I am not being backed by anyone, other than Genesi who
were gracious enough to give me an EFIKA at no cost.  Their hope is that
I would create a product around the board, and I would like to make good
on that.  They are a unique company with a strong open-source vision,
including open hardware designs.  They make the reference design, and
are first to be ready to market any products derived from it.  But
others can implement my project as their own product, either using
Genesi for the hardware or going it on their own.

I have a LOT to learn about all this stuff... but for me, that is the
point.  I get to play with cool toys and maybe in the end do something
that could be a benefit to others.  WiMAX is "cool" to me, so that was
my initial attraction.  I also am keenly interested in wireless
networking.  I am no fan of monopolies.  And it's also a great option
for rural areas and developing countries.  BATMAN is also very cool to
me and I have been following along here for a while, lurking on and
off.  But when all is said and done with the project... I don't need a
WiMAX mesh node for myself.  So I will turn the EFIKA into a car
computer when I'm done... there is already another project doing that
and I'll just copy off them at that time.  But for now I want to get my
idea moving forward.  I am completely open to suggestions and advice
along the way.

Thanks for being curious, and I hope you find my idea interesting.

Peace!

Tim

--------------030001010109030301050502
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
On Fri, 13 Feb 2009 03:26:13 +0700, Outback Dingo
<a class="moz-txt-link-rfc2396E" href="mailto:outbackdingo@gmail.com">&lt;outbackdingo@gmail.com&gt;</a><span dir="ltr"></span> wrote:
<blockquote
 cite="mid:mailman.134.1234470500.960.b.a.t.m.a.n@open-mesh.net"
 type="cite">yupp got me kinda curious also, though you can definatley
do stable long distance with wifi and the right antennas, what
advantage really does wimax provide, if any. Overall id be very
surprised if it was even really adopted. there are very few wimax
capable laptops even now let alone desktops.<br>
  <br>
  <div class="gmail_quote">On Fri, Feb 13, 2009 at 3:05 AM, Simon
Wunderlich <span dir="ltr">&lt;<a moz-do-not-send="true"
 href="mailto:simon.wunderlich@s2003.tu-chemnitz.de">simon.wunderlich@s2003.tu-chemnitz.de</a>&gt;</span>
wrote:<br>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hello
Tim,<br>
    <br>
unfortunately i have no experience with WiMAX, but as far as i know:<br>
    <br>
&nbsp;* WiMAX is not license-free like WiFi (means you need to BUY a license,<br>
&nbsp; at least in germany)<br>
&nbsp;* where is the technical advantage of WiMAX over WiFi?<br>
&nbsp; Sure, the advertisements say "50 km or 108 MBit/s", but they don't say<br>
&nbsp; "both at the same time".<br>
&nbsp; You can reach this with WiFi as well (with the right antennas and
setup).<br>
    <br>
So my question is: Where do you see the advantages in WiMAX over WiFi?<br>
    <br>
I don't know if there is some mesh technology available (as in<br>
implemented) for WiMAX (as far as i know 802.16d?) or if there are<br>
adhoc-like modes available to let routing protocols like BATMAN work.<br>
    <br>
If you know more about WiMAX meshing i'd be very interested to hear. :)<br>
    <br>
best regards<br>
&nbsp; &nbsp; &nbsp; &nbsp;Simon<br>
  </blockquote>
  </div>
</blockquote>
<br>
I understand you can get good range with WiFi using directional
antennae, parabolic antennae, "cantennas", etc.&nbsp; I *have* thought about
directional antennas for back-haul, but the project idea was geared
toward emergency workers being able to set up a network as simply as
possible.&nbsp; So I have been leaning toward a good solution to work with
omni-directional antennas.&nbsp; No "aiming" needed... plug and play would
be ideal.&nbsp; With directional antennas it would take a little more work.&nbsp;
But may be a better solution in the end.&nbsp; Nothing is set in stone here.<br>
<br>
I was going with WiMAX because, to my understanding, I could get a far,
far greater range using omni-directional antennas than I could with
WiFi.&nbsp; I do understand that the data rates fall off with distance.&nbsp; I
am not interested, here, in providing typical municipal wireless
solutions where the users are going to be working with rich content a
lot.&nbsp; I want to be able to set up a communications network that can
help rescue workers get access to logistics and co-ordination web pages.<br>
<br>
Mainly, I am interested in implementing SAHANA on this network.&nbsp; From
their web site, "Sahana is a Free and Open Source Disaster Management
system. It is a
web based collaboration tool that addresses the common coordination
problems during a disaster from finding missing people, managing aid,
managing volunteers, tracking camps effectively between Government
groups, the civil society (NGOs) and the victims themselves."&nbsp; You can
find more info at <a class="moz-txt-link-freetext" href="http://www.sahana.lk/">http://www.sahana.lk/</a> or
<a class="moz-txt-link-freetext" href="http://en.wikipedia.org/wiki/Sahana_FOSS_Disaster_Management_System">http://en.wikipedia.org/wiki/Sahana_FOSS_Disaster_Management_System</a> if
you would like to check it out further.&nbsp; So the primary application I
want to support is simply a web app on a server, and have it run
reasonably well over the mesh.&nbsp; I am not going for VoIP or streaming
video, so the top-end bandwidth is not my main goal.&nbsp; Distance is.&nbsp;
Ease of set-up is.&nbsp; But, of course, I will eventually have to do
real-world testing to see if the throughput would suffice.&nbsp; If I were
to do directional antennas, I would look to WiFi or Microwave just as
readily as WiMAX.<br>
<br>
Now as a secondary function, this disaster-relief network could also
support access out to the wider web, and it would be nice for rescue
workers in the Red Cross tent or what have some PCs connected to my
mesh node, using it as an AP into the mesh and on to the web.&nbsp; The idea
is not, even then, to support video conferencing or bittorrents.&nbsp; Email
to friends and family.&nbsp; Government and NGO resource web pages.&nbsp; Etc.<br>
<br>
The dev board I have is a 400MHz Freescale MPC5200B PowerPC SoC - based
unit called the EFIKA 5200B from Genesi.&nbsp; See
<a class="moz-txt-link-freetext" href="http://www.genesi-usa.com/efika">http://www.genesi-usa.com/efika</a> for details.&nbsp; I am going to outfit it
with a PCI to MiniPCI adapter and should be able to put two miniPCI
cards on it.&nbsp; Now here, I will note that I have only been able to find
a mini-PCI EXPRESS adapter (from Intel, and it also supports WiFi).&nbsp;
Intel's "Echo Peak"...&nbsp;&nbsp; "Intel&reg; WiMAX/WiFi Link 5150(512ANXMMWG) is a
1X2 MIMO (Multiple Input,
Multiple Output) 1x2 (one transmit chain, two receive chains) PCIe
Minicard supporting IEEE 802.16e and 802.11a/b/g/n wireless network
adapters that operate in the 2.4 GHz and 5.0 GHz spectra for WiFi and
2.5 GHz for WiMAX."<br>
<br>
802.16d tends to be good for fixed stations.&nbsp; And the idea is that
these nodes will pretty much stay put once set up.&nbsp; 802.16e is largely
being touted for it's mobile network features... and it is coming to
the US.&nbsp; Clearwire wireless broadband (802.11d methinks) is already
deployed in Nashville.&nbsp; Clearwire is now backed by Sprint and others.&nbsp;
Sprint's XOHM is also picking up steam.&nbsp; This is an 802.16e service
that is one "4G" route.&nbsp; Though for the cell companies, LTE is also on
the horizon.&nbsp; Sprint are supposed to be carrying the Nokia N810 tablet
now with WiMax in it.&nbsp; More and more MIDs, netbooks, smart phones, and
eventually laptops and such will be coming with 802.16e chipsets.&nbsp;
Especially since major cell carriers have been investing in this
technology.&nbsp; Sprint has infrastructure already.&nbsp; I am not so interested
in the mobile aspects of 802.16e though.&nbsp; I am interested in the MIMO
technology support, however.<br>
<br>
Licensing issues I will get to later.&nbsp; There is unlicensed spectrum
available here in the US.&nbsp; But as this is geared toward emergency use,
I imagine that there will be considerations regarding spectrum use for
such an application that may be favorable.&nbsp; More research is in order
here, I agree.&nbsp; At one point Genesi told me I had the Australian
government interested in my project, but at the time I had nothing to
show for it yet so I didn't pursue anything with them.<br>
<br>
Granted, this is a learn-as-you-go project for me.&nbsp; I have Debian
running on the device, but that's about it so far.&nbsp; Well, it also runs
Apache.&nbsp; I have to get some hardware to be able to do anything
constructive.&nbsp; I am not being backed by anyone, other than Genesi who
were gracious enough to give me an EFIKA at no cost.&nbsp; Their hope is
that I would create a product around the board, and I would like to
make good on that.&nbsp; They are a unique company with a strong open-source
vision, including open hardware designs.&nbsp; They make the reference
design, and are first to be ready to market any products derived from
it.&nbsp; But others can implement my project as their own product, either
using Genesi for the hardware or going it on their own.<br>
<br>
I have a LOT to learn about all this stuff... but for me, that is the
point.&nbsp; I get to play with cool toys and maybe in the end do something
that could be a benefit to others.&nbsp; WiMAX is "cool" to me, so that was
my initial attraction.&nbsp; I also am keenly interested in wireless
networking.&nbsp; I am no fan of monopolies.&nbsp; And it's also a great option
for rural areas and developing countries.&nbsp; BATMAN is also very cool to
me and I have been following along here for a while, lurking on and
off.&nbsp; But when all is said and done with the project... I don't need a
WiMAX mesh node for myself.&nbsp; So I will turn the EFIKA into a car
computer when I'm done... there is already another project doing that
and I'll just copy off them at that time.&nbsp; But for now I want to get my
idea moving forward.&nbsp; I am completely open to suggestions and advice
along the way.<br>
<br>
Thanks for being curious, and I hope you find my idea interesting.<br>
<br>
Peace!<br>
<br>
Tim<br>
</body>
</html>

--------------030001010109030301050502--

--------------000801080404000506010204
Content-Type: text/x-vcard; charset=utf-8;
 name="luvdownbabylon.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="luvdownbabylon.vcf"

begin:vcard
fn:Tim LePes
n:LePes;Timothy
adr;dom:;;2852 Lera Jones Drive;Antioch;Tennessee;37013
email;internet:luvdownbabylon@gmail.com
tel;home:(615) 361-4175
tel;cell:(615) 594-3846
x-mozilla-html:TRUE
url:https://alembic.dyndns.org
version:2.1
end:vcard


--------------000801080404000506010204--
