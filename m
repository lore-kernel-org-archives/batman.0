Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Jan 2017 17:54:57 +0100
Message-ID: <1560076.ER48KEDWps@bentobox>
In-Reply-To: <1484667540.3000.7.camel@sdl.usu.edu>
References: <1484596174-16341-1-git-send-email-jhaws@sdl.usu.edu>
 <4570303.DAXUuCGGu2@bentobox> <1484667540.3000.7.camel@sdl.usu.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2643948.4sSCiV7SFk";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH] IPv4 multicast distribution support.
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

--nextPart2643948.4sSCiV7SFk
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Dienstag, 17. Januar 2017 15:39:00 CET Jonathan Haws wrote:
[...]
> > > 
> > > +int ipv4_to_mac(const alfred_addr *addr, struct ether_addr *mac)
> > > +{
[...]
> > This will not return the mac address of the device. It will therefore
> > break
> > the synchronization code. see SOURCE_FIRST_HAND in sync_data and the
> > code
> > which sets data_source in finish_alfred_push_data.
> 
> You are correct - this does not return the MAC address of the device.
>  Rather it uses the source IP address.  Since we're dealing with IPv4
> in this case I believe it is safe to assume that the network has been
> properly configured and the remote node will have a valid IPv4 address,
> which is used here.  In my testing the synchronization and data sharing
> worked properly and all data was shared as expected.

It should not be synced between masters when the data was received from a 
slave (because the master will not detect it as FIRST_HAND). If it does still 
work then you have a bug somewhere else.

[...]
> What would you like to see here?  Would you prefer an ARP request to go
> and get the MAC address of the remote node?

Doesn't sound that nice. @Simon, do you have an opinion about this patch 
before Jonathan rewrites it? (It may take a while until he answers because he 
should be offline this week)

[...]
> > > I realize that the code in this patch is not formatted properly,
> > > but I
> > > was unable to get checkpatch.pl to scan this right - it needs a
> > > full
> > > kernel tree.  Is there another formatting script I can run?
> > What is the problem with downloading the kernel sources? And auto-
> > formatting
> > scripts tend to not get everything right and make things worse in
> > some cases.
> > checkpatch.pl is therefore only to point out some obvious problems.
> 
> I did download the kernel source, but when I try to run the script it
> either tells me that I don't have a valid kernel tree (when using the
> sources for my Xubuntu kernel) or that the file I'm trying to scan
> isn't part of the tree (when using the latest from kernel.org).  I've
> never used that tool in the past - can you send me a usage example for
> scanning a file in the alfred tree?

Just did this from my linux-next.git checkout:

    ./scripts/checkpatch.pl --strict --ignore=LONG_LINE_STRING \
      --ignore=LONG_LINE --ignore=LONG_LINE_COMMENT \
      --ignore=FSF_MAILING_ADDRESS \
      -f ../alfred/main.c

or:

    ./scripts/checkpatch.pl --strict --ignore=LONG_LINE_STRING \
      --ignore=LONG_LINE --ignore=LONG_LINE_COMMENT \
      --ignore=FSF_MAILING_ADDRESS \
      ../alfred/0001-IPv4-multicast-distribution-support.patch

Kind regards,
	Sven
--nextPart2643948.4sSCiV7SFk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAlh+TGEACgkQXYcKB8Em
e0adwxAAwyD5SfDPc7k7UsM4+bfzBpeM3FR49sKO7kdbD5i9JfpYjJzM8OBSmsxu
k9/e/Racn61vobW4H0FGtPs2BbvgpubhOB5VY5uEl++qMPXx0NH+gqH1w/VI0aNO
SKcwq0k6z0RDRJ563kDcMAEPMNOllCke4Npj9yGyMsNSyjR9m6zX7sPD6wX+H/g/
TpaEV5ud/kOTUMGgOAL02MjKJKJYaUkuvw7r4jRUsOmPBs1JUAoJ1xL5q3Jl705e
w5ltOAR2pCw/atHMVw5kHu97jiDuTh/FgUFQ3R4aw/n9SdRLGp08ZtB2sy5/qyEG
qzhCaOC+GE56/ruwKP45gOHXbs+l2Wj0ocChTG853Ex3pIVGKP61ZXy5Pi5HPo2l
LdAhKI2mNcXh0n7dl9yQD5ehhXorTGyQK9AUZLQVXnWsucxsbpOWZXg1o866xpNS
U9/NBbOsFpwwJwKUchIBx1ArHdjk+ONpEeezGuQgs3FN+eBl+UfOBiAez8OzN36B
P6xvwFroKGBzg1W8H6WwPwd53ZhbMTiTfYr/Kx3qXa4vCY2eAokxRtCiCR8mP3Iz
18py8VDYbWHMRZrBaV4Lyh6CgDpPdClar9CBcZhwGXUnQxdZvDJucuhr9GkXRYai
tVKkOn61BDrhN/L4t2gXtMQ3c8HGpDSpk+CSIpply7A0io/r7hU=
=p3yZ
-----END PGP SIGNATURE-----

--nextPart2643948.4sSCiV7SFk--

