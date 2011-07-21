Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Thu, 21 Jul 2011 08:56:49 +0200
Message-ID: <2942004.kRGEbDgGH5@sven-laptop.home.narfation.org>
In-Reply-To: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
References: <CA+qXHzNUGtLUpFqOmvKge05wLYyyoCpkTJG4HKwkd+Zzv81hYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3927866.coIe4YHnWD";
	micalg="pgp-sha512"; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7Bit
Subject: Re: [B.A.T.M.A.N.] Filtering BATMAN-ADV packet
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
To: b.a.t.m.a.n@lists.open-mesh.org


--nextPart3927866.coIe4YHnWD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="ISO-8859-1"

On Thursday 21 July 2011 11:33:55 Nik M. Anas Kamarudin wrote:
[...]
> /sbin/modprobe /lib/modules/`2.6.35.13/batman-adv/batman-adv.ko
> /usr/sbin/batctl if add br0
> /sbin/ifconfig bat0 192.168.5.41 up
> /sbin/ifconfig br0 192.168.5.1 up

Why has br0 an IP address (and one which seems to be in the same subnet
like the one from bat0)?

> and filter up the batman-adv packet using etables like this:
> `/usr/sbin/ebtables -A INPUT -s AA:AA:AA:AA:AA -j DROP`
> 
> BUT, this only work for Ethernet interface/ wire.. i need to do this
> same thing using wireless interface. Anyone got any ideas?

Why shouldn't that work on wireless interfaces? Maybe you should provide more
information about your problem or your statement is just wrong. Just to
provide a easy to reproduce counterexample: Take your standard ath9k master
interface, add it to a bridge and add the correct ebtables filter rules
(depends on the actual scenario, but just assume INPUT, FORWARD and OUTPUT
of of the filter table with the source/destination macs and DROP target).

And there is still the possibility to revert and extend
 http://git.open-mesh.org/?p=batman-adv.git;a=commit;h=660d20261343e0b2ff57e51e50d7eb0e557d5e5b

Kind regards,
	Sven
--nextPart3927866.coIe4YHnWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABCgAGBQJOJ82xAAoJEF2HCgfBJntGLa8P/icVNyOdzx43q10tHzie8Vkx
x3zHKUUr1uVeH552sFarx4hlKPlH6gNpOEmLFS00B5tKOki4aAfdOpt/aCZgYw9D
034kWIFBZWPVKbtFhErlIsRn5jxqMlxcMLeaBZESLazYA1aoT73K8WxwwJEzPhxT
3VDoNFDkSO847u2Dd503c/LtLZ9LqJJLzCWbykbenDjOyeoXtx0A5kC1bIQobMMC
Mq1fFOARePAyUhedj7I8EeoywMVKU8cwpQZ1zqGo3d2U3WXJVlpF3ytJjeGPua1D
cwfVMc5vuVCggXWI7QUb94ddXVmUX+26v3GUjt6KG3Wi4K2MVKnzPbTxm7/xRs2f
akiUNfZR/jBN5z/mgUnDTVzPMGFAu747naUwjan8uLmZBKsPLKugNp0wxn6bER+S
4cITn//50Ov9/H1jbpsh/JwYvRg5OJRHkgG0TMo4m5BEM7Rv9VSSX1Rya7ye9RMj
BdF6i3ITKhXACbUTyEFkkC8LsNSor5z66YgMc2fYQiulwNKaC5a34ejtkKekdKMr
TixQl64atpDyMxvpMbtAmh/09Aq+/r6C5tdsP8kB+DFGTJghVNTPdFRmY/TT8XLL
pvJWwD7lVzNr5Rc2bIsYKJ/AArHkE0RAki/kyiSlND15DA8aTqQNYXyh15mV+yAl
R3Ej2thifDDs+q3huRzF
=fQUQ
-----END PGP SIGNATURE-----

--nextPart3927866.coIe4YHnWD--

