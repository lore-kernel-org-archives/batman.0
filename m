Return-Path: <b.a.t.m.a.n-bounces@lists.open-mesh.org>
From: Marek Lindner <mareklindner@neomailbox.ch>
Subject: Re: Batman-adv packet retranslation
Date: Mon, 25 May 2020 19:27:32 +0200
Message-ID: <7073983.9WrHQ1J9Fu@rousseau>
In-Reply-To: <CAOVt3fGODcxuZAigHuHSgPED5Y67kB2NV2encCyDz4qMFy7gyQ@mail.gmail.com>
References: <CAOVt3fEEaLx8-58NjVXU0L6XToB5FPvGjFaEoZBeRCL+Eh-QWw@mail.gmail.com> <10714145.5AxrDinkzN@rousseau> <CAOVt3fGODcxuZAigHuHSgPED5Y67kB2NV2encCyDz4qMFy7gyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2583158.ocIN8Hk9gp"; micalg="pgp-sha512"; protocol="application/pgp-signature"
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n.lists.open-mesh.org>
List-Archive: <https://lists.open-mesh.org/mailman3/hyperkitty/list/b.a.t.m.a.n@lists.open-mesh.org/>
List-Help: <mailto:b.a.t.m.a.n-request@lists.open-mesh.org?subject=help>
List-Post: <mailto:b.a.t.m.a.n@lists.open-mesh.org>
List-Subscribe: <mailto:b.a.t.m.a.n-join@lists.open-mesh.org>
List-Unsubscribe: <mailto:b.a.t.m.a.n-leave@lists.open-mesh.org>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@lists.open-mesh.org>

 
--nextPart2583158.ocIN8Hk9gp
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 25 May 2020 19:21:50 CEST Alexey Ermakov wrote:
> > I am surprised you still are configuring a throughput override of
> > 100kbit/s. What's the idea behind this configuration ?
> 
> I have two channels between nodes (actually more, but this doesn't matter
> now) 1) Radio modem, connects as follows:
>    NODE1(eth0)<-->modem(radio)<-->(radio)modem<-->(eth0)NODE2
> eth0 interface have 100mbit/s speed and batman detects it as 100mbit/s.
> radio has 145kbit/s, and actual speed of this channel is 145kbit/s
> 
> 2) eth1 Ethernet channel. Speed of this channel is 100mbit/s
>    NODE1(eth1)<---->(eth1)NODE2
> 
> Now make a test:
> 1) Set up eth0 modem channel
> 2) Disconnect eth1 channel
> 3) Turn on nodes - batman saw eth0 channel between nodes and detected
> speed 100mbit/s (because speed between node and modem is 100mbit/s, as
> I understand)
> 4) plug eth1 cable in - At this moment I expect batman switch to eth1
> channel because it has real 100mbit/s speed. But batman doesn't
> switch, because it detects eth0 as 100mbit/s too.
> Therefore I override throughput of eth0, actually batman detects
> incorrect speed on eth0.

If you have to configure the throughput manually why not configure the link with 
something like 5mbit/s instead of 100kbit/s ? Batman-adv does not care that 
this throughput is not exact. All that matters is provide input to the 
algorithm to allow batman-adv to make smart choices.

Kind regards,
Marek Lindner

--nextPart2583158.ocIN8Hk9gp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEI5CG6MPJfr3knG//U1VOj+62HMAFAl7MAAQACgkQU1VOj+62
HMBs6Qf/XXUiwnMu6XzAlsd2ls/ydp35yL/J6Mov4rQhAg97YBJFtl/ryil3o2cX
dHWnAGQUfyftavPkM2r2c3iNZnytzdh/Pq5+7qCQVq6wVmb0+ZSEu3h4SotnFpPe
kAlk4+b2o1WbopnxKNhmKgnthQ2BO4TDx3aG41FftPQvXyKwkl+2VoHG6TGBa5AY
ugW0tJtn5oZIwILNDMIvGKNQln/ZnkeVYwhstPDaxTxNxWgCy3ESs3dz8+mN3xmk
LbRtsYRCK1SYaQFBxfJ2VSlqg4r2wk2cTMeNxUTlmWmcHC09vSJZ1WzxpUlfRhhe
AxHzxAyt1lqgLrPehhzG+vOSUa8uEw==
=12fU
-----END PGP SIGNATURE-----

--nextPart2583158.ocIN8Hk9gp--


