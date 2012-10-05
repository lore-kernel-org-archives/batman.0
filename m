Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 05 Oct 2012 09:11:32 +0200
Message-ID: <1710035.x7kxmPdvcU@bentobox>
In-Reply-To: <CA+h5VgqcOikZGAGhw7Ztz+H6E8EtA39o0V-qFYxPGRv=d4ws=w@mail.gmail.com>
References: <CA+h5VgqB82br1u9Cdg423Eedd8m23wMO=PWo86q+TTAXVtuy8Q@mail.gmail.com>
 <1934520.YmdkrNAjpg@bentobox>
 <CA+h5VgqcOikZGAGhw7Ztz+H6E8EtA39o0V-qFYxPGRv=d4ws=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2982921.pgXc64C2ch";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] mac address from packet
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
To: Dominic Follett-Smith <dominicfollett@gmail.com>, b.a.t.m.a.n@lists.open-mesh.org


--nextPart2982921.pgXc64C2ch
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 04 October 2012 21:30:24 you wrote:
> However we need the mac address of the neighbouring station that sent
> the OGM. But we are not sure how to go about retrieving the mac
> address which is part of the ethernet mac header at the beginning of
> the frame.

You don't have this information when you receive the data through an UDP 
socket (this is one of the reasons why all development is now done in batman-
adv). What you can do is to rewrite the batmand socket handling stuff using 
PF_PACKET. Small hint: you should use BPF to reduce the amount of packets 
received by userspace since your HW doesn't look really powerful. Even better 
hint: BPF codes can be created using tcpdump. Here an example for udp port 
4305:

$ tcpdump -dd 'ip and udp and port 4305'
{ 0x28, 0, 0, 0x0000000c },
{ 0x15, 0, 10, 0x00000800 },
{ 0x30, 0, 0, 0x00000017 },
{ 0x15, 0, 8, 0x00000011 },
{ 0x28, 0, 0, 0x00000014 },
{ 0x45, 6, 0, 0x00001fff },
{ 0xb1, 0, 0, 0x0000000e },
{ 0x48, 0, 0, 0x0000000e },
{ 0x15, 2, 0, 0x000010d1 },
{ 0x48, 0, 0, 0x00000010 },
{ 0x15, 0, 1, 0x000010d1 },
{ 0x6, 0, 0, 0x0000ffff },
{ 0x6, 0, 0, 0x00000000 },

This code has to be attached to the "PF_PACKET, SOCK_RAW"-socket using 
setsockopt's SO_ATTACH_FILTER.

The packets can be received using recvmsg (don't forget to use MSG_TRUNC or 
you will get problems to differentiate different packets. Your biggest problem 
will be the handling of fragmented IP packets... but you should not get them 
when you listen for these broadcast announcements.

Kind regards,
	Sven
--nextPart2982921.pgXc64C2ch
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABCgAGBQJQbogkAAoJEF2HCgfBJntGMHcP/3J6GC7CUn/RfxCxAKFBq+ak
YGjtdGIc74B1Yr+iKo00MSASjFX5LW8zZ8UHUT9p5FCBeVHUs/layFdgyq7Tytc6
MOqjTEGfaSFSvyeqJpTZKVrQuYMliI5GjlK4ldkUq+bNK33nnRgzeW+KXCkX5dLp
V59/CbrUueoaUnTBk7/5Q59+TUH2JY6gJckQgIKHde2QK1qZ6fhjDp9k8uLS1val
zH3OcHzv72NTzgob3o2Fs8VNGg59B+M9nupY9Ha1d1x5lWgyY2d83JR7Urx166Nu
nbxaDuaT+q43aX/Z7Y/s8eenp7YK8SvB+bFqbUiOfDIIsvn5GSiZqsEa1ckHX+ci
V3wr9DzUFIQs9cE9dKnqsHPrivpl9TrEsu62YLocH8tkILsfbEAQSTEUCbj+zxDT
cifmpER2fNRy/5a7lHK6jBnT1QHPR2g0dcHzm+6SIX+Tduy0DvZ9k73YrtV7hpkW
5za5W1JeuZ2ii+hj/OJiXUZ5GrtdVhKmzFrRw1wQDSXguvfbKMUbUreWNVZT/9rU
AzsdDE60fK+wF/UAYoCesbMNPZohQqVQjRmZbQ0vbB076EWK9d7FDuIJaCmz7XlY
zaSZZTIn8q5nGf3Yq9z+xnFi7kRl/d7rWSTnLEoLJFOUFSu9iqqcYw4cFf92+wCq
KxqPmNwqj8P7RLD9uZ3s
=/hND
-----END PGP SIGNATURE-----

--nextPart2982921.pgXc64C2ch--

