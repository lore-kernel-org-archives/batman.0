Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <20120329125126.GA22422@pandem0nium>
References: <CAHD-aqKv+7SDGC-07Or+xOZKiJATPmOy876SnDawJp_Zs0GZvg@mail.gmail.com>
	<201203261747.17373.lindner_marek@yahoo.de>
	<CAHD-aqLmGQwzK1u8vmgEwpbNTPMZuonJikjkT=uaOkcPedFptg@mail.gmail.com>
	<CAHD-aqLs8kr5Bwk4-5gBuNepQUmX78yeAHRxRjSLQJw10=fkyA@mail.gmail.com>
	<20120329125126.GA22422@pandem0nium>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Fri, 30 Mar 2012 01:11:35 -0300
Message-ID: <CAHD-aqJU-HWV9MHkrkP9efKyzygNkuetA2H4wHYJuKv=ur5Thw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] BW degradation on p2p links?
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

Simon, you saved my day,

On Thu, Mar 29, 2012 at 9:51 AM, Simon Wunderlich
<simon.wunderlich@s2003.tu-chemnitz.de> wrote:
> the problem using one radio is explained further here (from another
> company, but this applies to any WiFi mesh technology)
>
> http://revolutionwifi.blogspot.com/2012/02/mesh-network-performance-impact.html

I was fully aware of this problem with single-radio nodes, and that's
why I was trying to build cheap two-radio nodes using mr3220 + usb
dongles.

>
> Also, if you use two-radio nodes,
> they may interfere with each other if the antennas
> are near to each other. There are quite a few ppl who can confirm this,
> e.g. check this:
>
> https://hackerspace.be/Wbm2009v2/TestInterferenceResults

Ah! you hit the nail right in the head!
I walked around the battlemesh wiki a couple of weeks ago, interested
into past events results, but only came across an rsync daemon serving
a tree with videos, photos and results, mostly in raw data form,
collected during the last (before athens) WBM edition.

I think i was a bit short-sighted, since the Wbm2009v2 link (and the
rest of that wbm wiki) was a wonderful read!

I did a couple of tests, and indeed increasing the distance between
the dongle and the router makes the whole difference.

I googled more on the subject and found a paper with thorough testing results
http://edoc.hu-berlin.de/oa/conferences/reSNAVwf8bA/PDF/28TjAjjEtU7ts.pdf

and even finer-grained testing here
http://userver.ftw.at/~valerio/files/wons.pdf

None of them use 802.11n equipment, so i set out to make my own experiment.
In my case, i needed about 1.5 meter between omni antennas to achieve
full throughput, placing both omni antennas perpendicular to the
ground and on the same plane.
On the other hand, if i place them one over the other (that is, align
their vertical axis, while holding them at different altitudes) a
distance as little as 20cm was enough to overcome interference.
(Sounds reasonable given the omnis gain spatial pattern)

I was able to get 20mbps from A to C (and viceversa), hopping on B.
[A ch=11] -- [ ch=11 B(2 radio) ch=1] -- [ch=1 C]
This was done using either BATMAN or static routing, giving almost
equal results (~1mbps less using batman)

If i put the two radios in B really close to each other (<5 cm)
throughput fell down to 8 mbps.
It's a relief it was such a simple issue!

Thanks a lot Simon and Marek for getting me into the right path,

So far we haven't heard of anyone implementing OpenWRT+batman-adv on
mr3220+usb to build two-radio-nodes mesh network, which means we're
mostly in a "solo adventure"
so your help and attention was even more appreciated!

Guido
