Return-Path: <sven@narfation.org>
From: Sven Eckelmann <sven@narfation.org>
Date: Tue, 17 Mar 2015 07:52:05 +0100
Message-ID: <3303873.p3ScDyqLol@sven-edge>
In-Reply-To: <5507B4A5.5050905@gmail.com>
References: <1426419015-31756-1-git-send-email-anatoliy.lapitskiy@gmail.com>
 <2573454.vIxcRXbgX8@sven-edge> <5507B4A5.5050905@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1784834.GJGsDUCoPl";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
Subject: Re: [B.A.T.M.A.N.] [PATCH v4] alfred: Add "--update-command"
	parameter
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
To: Anatoliy <anatoliy.lapitskiy@gmail.com>
Cc: "'b.a.t.m.a.n@lists.open-mesh.org'" <b.a.t.m.a.n@lists.open-mesh.org>


--nextPart1784834.GJGsDUCoPl
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tuesday 17 March 2015 06:59:17 Anatoliy wrote:
> I'm still not sure about
> buf[sizeof(buf)-1] = '\0';
> and
> command[command_len - 1] = '\0';
> lines.
> 
> As far as I know snprintf appends '\0', so "buf" will always have null
> terminator. And so command will always have \0.

You are right for buf. snprintf indeed guarantees termination with \0 for size 
> 0. So please remove the buf line.

But strncpy doesn't guarantees this. So please add the line after the strncpy 
into the buffer command.

> Should I rebase my commit to after new public commits?

Your patch must apply on the current master. If it doesn't then please rebase 
it.

> Is there a link to code style used in project?

Already gave you the two relevant links in a previous mail.

Kind regards,
	Sven
--nextPart1784834.GJGsDUCoPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCgAGBQJVB88YAAoJEF2HCgfBJntGi2wQAJvqCclzxg4DVsXgbR0Fyvnq
+R7zu3KWMD1qG3zPfRgl9nxl6pSntCyNq3Pm2XQN+3JOLHXHFNaCg8ItT6cxb4iz
ceUixT4UP7DFttMP2Bc1hVdzksda3XtVSz6aLSxmED1+yUSFBYdpxclftil8MtkA
Qz2tTwfSxMzFbZskg77EMqyl0HUFVznhnwfXK1m7vI4t8pQEf6/3zkzfAVYnxRdi
JQ5Pz5SFcY2WLt5L0B3O/zWcxFwS+bmMBO0yNQoJJH8ZQefLEmxqFbMvN0iqyDaD
fQK3CVmXjbWQUqoCm2EEPER/+Ey9F9bnruPVPg3dz9R257TCpaTZg/0LntzWcdNs
839n7xecTgAkzDHJ208Nl+MulG9MFxdp8q8oD1jN6r2f8tT9lKmSe7FuYcG7rGE+
p3bznf0nOEH2jrjidbN5BKWbU2I88P5yzkjmofqWJi3ET4rmdV4zE24pxixgqvFm
KvQfo+CT/nIWSg5feq3NC42luGppfl+fN/K9u8cA0XEBUxuz/jduY2EZQ3qjcn3p
OkysymNRLklj7n6g6Tr5IH0GK3HMYALPTPXPy6B4w85G9MStiyfhVBjAZTGwEKwZ
LYYpO3NxOVqPpx41rOnAPJoRUHr+O1bbSRONaZkAhHxPvWtLjnjGa1jtuNYRR+N4
1YmJIBaHz/49Xup5ecXb
=u3ZO
-----END PGP SIGNATURE-----

--nextPart1784834.GJGsDUCoPl--

