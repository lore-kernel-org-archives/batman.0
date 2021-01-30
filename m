Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Sven Eckelmann <sven@narfation.org>
Subject: Re: Mobile Vehicle Mesh Network
Date: Sat, 30 Jan 2021 10:27:43 +0100
Message-ID: <46059336.7T9GjFi5hl@sven-edge>
In-Reply-To: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
References: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2040151.7kSeADS9zo"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: Scooter Willis <willishf@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org

 
--nextPart2040151.7kSeADS9zo
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Scooter Willis <willishf@gmail.com>
Cc: b.a.t.m.a.n@lists.open-mesh.org
Subject: Re: Mobile Vehicle Mesh Network
Date: Sat, 30 Jan 2021 10:27:43 +0100
Message-ID: <46059336.7T9GjFi5hl@sven-edge>
In-Reply-To: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>
References: <CAMjFWEOpvMmedQw7sB-G1f9pMMo6ymhZemVy07Y0UeUN+EPU1w@mail.gmail.com>

On Friday, 29 January 2021 02:43:25 CET Scooter Willis wrote:
> Doing some research to see what options are available for a hybrid
> mobile-mesh network.

Let me summarize your mail (because I had some problems with your writing 
style):

* multiple ceiling mounted "AP"s

  - connected to the same network
  - "relevant services" are behind the AP

* multiple mobile clients on the floor

  - roam from AP to AP
  - client must be forwarding traffic from local devices (connected via 
    ethernet)
  - it is unknown what mobility can cause in quality changes

    + usually the speed and therefore the gradual change in link quality is 
      bound to a specific rate in an "open" environment"
    + but unknown whether it is also possible that a link suddenly disappears/
      degrades due to environment factors - which is somewhat likely in a 
      warehouse scenario

  - might be out of reach of an ceiling AP

    + mesh technology should be used ensure connectivity to the relevant 
      services


In your original mail, you left out some information which might be relevant 
for the discussion. So  we have to go through some of them:


1. what technology is used for the AP to client connections?
============================================================

My first assumption would be standard wifi infrastructure mode. The APs allow 
multiple client to connect and a client is only connected to one AP. It is 
(from AP perspective) a star topology with the AP in the center and the client 
as layer 2 endpoints. 

But keep in mind that this mode is not meant to have multiple layer 2 devices 
behind a single associated station. Or in other words: you cannot bridge your 
ethernet interface with the wifi managed interface on your mobile clients.

So you have some options to still get the multiple client devices connected to 
the relevant services.

* enable 4 address mode on both AP and client. And then pray that both are 
  handling it in a compatible way. But usually works fine when both are 
  running the same software stack (like OpenWrt with a similar set of drivers/
  wifi firmware).
* use a higher layer routing (like IP routing). But could be problematic when 
  you need a layer 2 connectivity. Or can get more complex if you don't use a 
  central place to terminate the layer 3 routes towards the network with the 
  relevant services
* use also a layer 2(.5) mesh technology over the links between clients and AP

Another option would be to drop the standard wifi infrastructure mode setup 
and just use the same technology between the ceiling nodes and the mobile 
clients as you would use between the mobile clients. Of course, then you would 
most likely need to be in "full" control of the APs and not only the clients. 
And depending on the mesh technology, it can work a lot better or only create 
more problems due to more links with dynamic quality characteristics.

In batman-adv's case, you would have for example following differences:

* ceiling node to mobile node link is NOT part of the mesh

  - exchange of client information happens with TT [1] and roaming
    features [2] - usually really fast
  - allows APs to be bridged when the bridge loop avoidance is enabled [3]
  - but quality information for the ceiling node to mobile node are completely 
    missing

    + so it is unknown the mobile node whether it is better to send it data 
      first to a mobile neighbor or directly to the crappy link towards the AP

* ceiling node to mobile node link IS part of the mesh

  - the quality of the link between ceiling node and mobile link is measured 
    like the other wifi links
  - hopefully better routing decisions
  - usually slower route switching time when comparing to the TT "roaming" 
    times



2. how important is the "wifi noise" factor?
============================================

Mesh technologies need to detect neighbors and somehow find routes between 
nodes. This doesn't come for free - usually in form of additional data over 
wifi, cpu and memory usage. But the details depend on the used technology.

batman-adv is using OGMs to inform neighbors of their existence and let 
receivers make informed decisions about their next hop towards a specific node 
in the mesh. These OGMs have to be sent often to allow the nodes to converge 
towards "good" routing decisions.

This means that a lower originator interval (aka more OGM transmissions) can 
be improve the convergence speed which is beneficial for mobile setups. This 
should acceptable well for networks which don't have sudden loss of nodes. For 
mesh networks were "intermediate hop" nodes suddenly disappear, it might still 
need a significant time until the old route via this disappeared hop is 
dropped. There were some ideas [4] how to improve this situation but they were 
never implemented.


3. how about new/experimental mesh technologies?
================================================

This is the B.A.T.M.A.N. mailing list and the mail explicitly asked about 
batman-adv, but I could imagine that you could have fun playing around with 
various technologies in a scenario with mobile node and drastic changing link 
characteristics. While there is no magic bullet - marketing might disagree -
at least interesting things might be out there.

There are (more or less) recent research in technologies which are more focused on highly mobile setups. You'll find these kind of mesh
technologies usually with features like

* multi-path routing
* redundancy
* forward error correction
* ...

to achieve resilience to mobility. Often by taking advantage of the
broadcast medium and dropping the standard paradigms of the 802.11
medium access - which is a different concept than what batman-adv
tries to do.

(small disclaimer: At least one batman-adv [5] is doing research in related 
technology and I could be considered slightly biased because of it).

Kind regards,
	Sven

[1] https://www.open-mesh.org/projects/batman-adv/wiki/Client-announcement
[2] https://www.open-mesh.org/projects/batman-adv/wiki/Client-roaming
[3] https://www.open-mesh.org/projects/batman-adv/wiki/Bridge-loop-avoidance-II
[4] https://www.open-mesh.org/projects/batman-adv/wiki/RIP
[5] https://git.open-mesh.org/batman-adv.git/blob/HEAD:/MAINTAINERS
--nextPart2040151.7kSeADS9zo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmAVJo8ACgkQXYcKB8Em
e0Ypzg/+OsOBGNgIBw3kqgTa8JDTxf0i2pYCO3/J31RzMJRIaQ6AOzhFsFlhr2JE
YQ1A/LG0XIVFQYxoPGM02Yr8OVwLBYypyabAAXpyXq001RqxZkcbYu8gDQ7O7J65
oog6Km6KaDKB2+Qhcn1nXlLdgjZP3X4EHSgg5NKn8XKZ4nIF7SoLk0PQijfapR2/
lzZN1R19UuS21ipyk2oEGpnVSPPKDNX6BzQFTWU4nCQOv9/lS+i8uQ2vBDyKOVTe
GgrZLGj8wTBs48m9gaoDmX/BI0vmaEPGETr1h0pKQk8igEO19fXFm+881y8Jp3tk
J4HQX0VXigSEAL5gqrW/ZWvcDBvaWEg5QCa30tYuMksUGGou3aZsbVC/iwlqZukT
ZrdOvHD0Kc5mk9P1MasYH6Y+RxkFpjq4JCfU2TRq7t5w1yQVkGNVNoLReewFsbq3
vwXstfqZSo6eAxtb7LeK8McONlBSC/B9Nu6IsYR8TFUM9XG3Btv0CnnGKpMG3W4+
RZqImPblpH0lFUNWZD3sn4Zb4hTd3MINtuz5OqPfdt0ddN+JMR303i8ez+MjxwQv
p6DPGKqu1ymVFgJAW04UGx7kHXw0f5C4bl0Djda8X/swF6+cCUFzqFhfMMr7nDKb
KvNQrp3gXZ4sSSWDtRHFxvSbWRIxmm9UCixIFi1wf6AC/Zm3Vh8=
=HJEo
-----END PGP SIGNATURE-----

--nextPart2040151.7kSeADS9zo--


