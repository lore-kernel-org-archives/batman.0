Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Sun, 31 Dec 2017 14:18:48 +0100
Message-ID: <1824062.p4cHhaC8Qk@prime>
In-Reply-To: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
References: <08d40a5302ac411895c49cf6b7e17d5b@MB82.inbox01.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart22951685.NbIV9ONPGL";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] Can b.a.t.m.a.n. be configured to ARP for
 unknown clients?
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

--nextPart22951685.NbIV9ONPGL
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, December 29, 2017 5:01:23 PM CET Robert Bates wrote:
> Hello,
> 
> Is it possible to have b.a.t.m.a.n. ARP if packets are received at bat0 for
> a client which has been removed/deleted due to timeout, and is therefore no
> longer in the translation tables?
> 
> In one customer application of a product of ours (a mesh AP we've licensed
> from another vendor/developer, which is based on openWRT/b.a.t.m.a.n.), we
> are being adversely affected by the 10 minute inactivity timer on
> transtable_local.   The clients in this customer's network/application are
> stationary devices which basically do not speak unless spoken to (e.g. when
> they are polled for data).  They are periodically polled by a management
> platform, using an upper layer protocol running over TCP.  The problem is
> that this customer's polling cycle time is variable, and occasionally it is
> taking longer than 10 minutes between successive polls of a given
> client/device.  When this happens, that client is of course removed from
> transtable_local, and transtable_global on the other nodes in the mesh. 
> Meanwhile, the polling/management platform has a very long ARP cache life,
> so it never ARPs (and apparently it is not possible on this platform to
> have the customer implement dynamic, rather than static ARP table entries,
> in which it would ARP upon polling failure).  So once we get into this
> state, polls to this client device which has dropped out of the mesh are
> not possible, and their management platform throws alarms, etc.  To bring
> it back in service at that point requires an ARP, which the customer is
> manually triggering with a ping, whenever one of these "outages" occurs.
> 
> We know that the transtable_local inactivity/removal timer value can be
> extended, and we will probably do that, but we would also like to know if
> it is possible to have b.a.t.m.a.n. ARP for the removed client in this
> case.  We prefer this approach, rather than arbitrarily changing the
> tt_local timer to some value which may not work well in some other
> customer's network/application.  I know that there is a statistically valid
> underlying assumption with this 10 minute inactivity timer on
> transtable_local, that clients will typically be "chatty".  But again, that
> is not the case in this application, which is a very common one in the
> industry in which we operate, where clients are very often fixed devices
> which only respond to explicit queries or commands.  This is a new product
> and protocol for us, and this could beg the question of whether or not
> b.a.t.man.-based meshing is the right solution in this type of application.
>  We believe it can be; it would just be helpful if we can configure it to
> ARP in this type of scenario.
> 
> Can you please comment on how this might be possible (config or otherwise)?

Hi Robert,

batman-adv does not ARP on its own, so there is no way to configure this.

You should either increase the timer from 10 minutes to something (reasonably) 
high, or have another program sending some frames to refresh the ARP on behalf 
of the client - e.g. every 5 minutes, read the transtable local, send a packet 
for each MAC. However, in my opinion, this is just a more round-abot way with 
possibly more pitfalls on its own.

A general way to handle this would be to send those unicasts unknown to 
batman-adv  as broadcasts. However, this would be problematic for networks 
with big broadcasts domains which already suffer from too high broadcast load, 
but have a sane ARP mechanism in place otherwise.

So long story short, increasing the timeout seems to be the most easy and 
effective solution to me.

Cheers,
     Simon
--nextPart22951685.NbIV9ONPGL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE1ilQI7G+y+fdhnrfoSvjmEKSnqEFAlpI47gACgkQoSvjmEKS
nqE8/A/9Hky6qgNMFrBu/QLacq1gMThfOXryIDD0faKhd6tBBvmx7rDB94yGUSr8
0IXeCMUI6RqyB9YXpZsclnGgKEVVBNYHrJVX/D06yw48FE8oiIpObl/qrDnTjr0h
QpQTlTpMScYNoiLV0zDdyvbYoPKsMW7QYort36g3gS+GIf/61ThzJmDiPtdPYhkw
40WMFOnfwAXKBbneX4F8V0JnzjFzQEneOaQ6zu2wV6kwblIiUR1HJY6eFEk/18aD
VcxKNwFxTBwM96N53wVCc1PGzStNIBQrJI4g3l9Q7XwMo1EbKigniK6JGhMROyQW
lPMVPzjkjnScG1q8vqe3Qf3SVHYDAS13Ljs7cDG8CP5ZmKmojuEz/bK7DUDO8+Vo
z8LOOYTrc5Dg3opZI96Sh/bDzAsR1Q3llnbZSQVABOTi4ktwF5zmGhISbBETFy01
LjENldkK0UQTp7kOZaOR+CaZ6KaLFjROXUCaTmjq+2z95mXsDm/XQU8X3bIVpBBD
iB8OqRFultvknYgQzuC+SLCykmciHK3ngS+6Sjb19Wl4ITlOmKIIXqIVZCfKz6lX
4JtH3qHtzIC5FfeG+QGOf//u0jLIdKO20tyD55MYlMRalEsOEvop9Mk/iX/GfDqI
I+HfuGk8t5IxCjh/qJpfEQ3dLNJ1pePKvqi93vM3JHEBmEEV1PY=
=d+Af
-----END PGP SIGNATURE-----

--nextPart22951685.NbIV9ONPGL--

