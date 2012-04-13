Return-Path: <mmitar@gmail.com>
MIME-Version: 1.0
In-Reply-To: <86BF280A-4090-4396-A4B2-94E69FC79F60@solvare.se>
References: <CAKLmikNxzz_zNwui4xejaAgvXXsHrTUGCPG+UT-cSH5iP3cEJw@mail.gmail.com>
	<4F86B02B.9060900@gmail.com>
	<CAKLmikNuMEiG2SN+H8bJkwRXszMayPpn_qDcf1faCjhrow6NdQ@mail.gmail.com>
	<201204130017.31711.lindner_marek@yahoo.de>
	<20120413062241.GA14395@ritirata.org>
	<CAKLmikN=yGHL8QZomD=GsaKYcZchd=r7kvsjsyxMCx2CYNjbzw@mail.gmail.com>
	<86BF280A-4090-4396-A4B2-94E69FC79F60@solvare.se>
Date: Fri, 13 Apr 2012 15:32:59 +0200
Message-ID: <CAKLmikNBtZ=KZW_vSG_6K8QXLf8aOxxTzkStf0YTnkOD-xSoLg@mail.gmail.com>
From: Mitar <mmitar@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Migration to Batman
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

Hi!

On Fri, Apr 13, 2012 at 10:52 AM, Christian Huldt <christian@solvare.se> wrote:
> Just asking to educate myself.

I am also doing that.

> Why would you use L2TP rather than just IPsec?

We want UDP transport. Does IPsec tunnels support that? And
furthermore, we do not want/need encryption. The main reason for going
to L2TP is that currently we are using OpenVPN for our L2 tunnels and
have problems that our links are CPU bound and not bandwidth bound. So
we would like to go to a in-kernel solution and probably without
encryption. (I doubt that Fonera can encrypt 20 Mbit/s. I even doubt
it can route that over L2TP. But I hope it will be better then current
5 Mbit/s limit.)


Mitar
