Return-Path: <sw@simonwunderlich.de>
From: Simon Wunderlich <sw@simonwunderlich.de>
Date: Mon, 21 Mar 2016 13:29:19 +0100
Message-ID: <4157766.3ikgnCPmEQ@prime>
In-Reply-To: <e5bc47fb3a536ddda2923e4d85773cb4@hilses.de>
References: <1458551033-8734-1-git-send-email-hwhilse@gmail.com>
 <2352013.EmfB5eiPMC@bentobox> <e5bc47fb3a536ddda2923e4d85773cb4@hilses.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3912672.nQDPIgL98e";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [RFC] alfred: implement TCP support for
	server-to-server communication
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
Cc: Hans-Werner Hilse <hwhilse@gmail.com>

--nextPart3912672.nQDPIgL98e
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="US-ASCII"

Hello Hans-Werner,

On Monday 21 March 2016 10:38:55 Hans-Werner Hilse wrote:
> Hi,
> 
> Am 2016-03-21 10:13, schrieb Sven Eckelmann:
> >> +int connect_tcp(struct interface *interface, const struct in6_addr
> >> *dest)
> >> +{
> >> [...]
> >> +}
> >> +
> > 
> > Wouldn't this hang for a while and make the alfred server
> > "unresponsive"
> > when the remote is not reachable at this moment?.
> 
> Yes, it most definitely would, you're right.
> 
> If the route I'm following is generally right, I think I'll work on this
> part (*that* I can make into a different commit). The connect() can be
> made non-blocking, and I would add the socket and the request to send to
> a list (possibly using the transaction list that already exists right
> now).

I think you are on the right track - in the ticket, we discussed whether we do 
TCP or just decrease the fragment size, but doing TCP is probably the more 
reliable option to do.

I agree that we should definitely use nonblocking operation.

I was also thinking that we might want to use TCP in general when the packet 
size reaches a certain threshold (e.g. >3kB), and always use UDP for small 
packets. Then we would also not need the commandline option (unless you think 
we should leave a way to force a mode). Any thoughts on that?

I don't think you have to split your patch further, at least I don't see a 
good way right now. I didn't do a deep review yet, but can do in the next 
iteration with the nonblocking stuff implemented. :)

Thanks a lot for taking care of this!
     Simon
--nextPart3912672.nQDPIgL98e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJW7+kfAAoJEKEr45hCkp6hTeoQANAOw3giHUSQMjb8b6Ts2Vyk
iTJqeo2sP7P8T1k219WPDt3USNBvzVsrx0vl5v6qGjfylEPjMTNPDhN+YVJ7Iy6O
LspvA1HB1AXJGVQM8xwa4IDjl1xdayqU/udi++vszAg4sSq/yQKAX7ws2F2rnkHt
ufFfSbfLsLQmuQBeCfyBG68qUXB0lxBdGwngjArAtrdAvhkif/WN5iDF1fwhoY98
hCI49fuRkVZReG18rEvXQ7e6G3AkAU96hAgVl25QGxn5YfY43mmOJm7ztgo1aOFo
dU7m977X8NYGwcup0M2Ix//W70WY3188WoUFXwpdnhvtchCSVue1n8x2p+FwPSaF
7UeMbalEniUEshqLUikLpCXEuPChdgbnI3LEjzA0lFhxjs9g9OUJOe0qK8grgIGG
cj07Ccf8WebWLRUTJKjNrKH8xJLUL9wtAId3ZqFVMoFbd/gcx4ZQ4ZrdYyGq1MuO
qPpji7++4miy3zNXqKE7Kwtt1QVYF3jLDNfZ/P6+QQfgTeG7Q2xpsCvIL9JAxmoS
boms3Vhz1r41cH0ClvLFaV3AfITaDUEh3asfbSmCEeruWjW7d/j5Fn2mtnZrQWOZ
3mO+Ct5fJcY+4owv6QpxGJT8/Ibxba+qw7Y8Mv5C9asdrVOvxrxGhHKc+5dYpPno
VKlxXQlB8CUAGrEStLEs
=TriI
-----END PGP SIGNATURE-----

--nextPart3912672.nQDPIgL98e--

