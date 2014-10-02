Return-Path: <dandenson@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAEbDFcQ3hoY+QTHMfawkKKPCLGWYsN1zJw068fr-7nsxnp4aVg@mail.gmail.com>
References: <CAEbDFcS4qbcr6RPH_ihTx31QgGW-K4tHxPVKQAokTPiEgAJcrw@mail.gmail.com>
 <7903470.eFDOnKYHmK@diderot>
 <CAEbDFcR-LgU3+dBsuKyekNS03fOdPBFSRtxpA70AuB9=No2u_w@mail.gmail.com>
 <3844641.7Py5KLv2R0@diderot>
 <CAEbDFcQ3hoY+QTHMfawkKKPCLGWYsN1zJw068fr-7nsxnp4aVg@mail.gmail.com>
Date: Thu, 2 Oct 2014 14:22:38 -0600
Message-ID: <CAA_JP8VThaSQo1VgpWT8CGWXy=Ju4RdeJppfiKxrb8J0Ep+78w@mail.gmail.com>
From: dan <dandenson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] QoS in BATMAN-adv
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
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

How is your progress?  I'm wondering how you are doing the QoS w/
batman-adv..  If this were routed you could use tc or tcng to
prioritize DSCP tags, but I don't see that as an option w/ batman-adv.

I'd be really curious about this.  I'm exploring batman-adv mesh nodes
for extremely dense forested neighborhoods* where my traditional fixed
wireless systems can't reach.  The catch here is how to handle QoS.
With so many potential radios and changing hops I want the radio's
queue to prioritize and haven't gotten deep enough into batman-adv to
figure out how this might be done.


*looking at mikrotik's rb912 in 5Ghz + R11e-5GacD mini-pcie radios for
a single device (running openwrt), two radio node and running the
ethernet into the client w/ POE injector.  No clients would be on the
wireless interfaces, just backhaul.
