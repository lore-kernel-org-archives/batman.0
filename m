Return-Path: <guido@guidoi.com.ar>
MIME-Version: 1.0
Sender: guido@guidoi.com.ar
In-Reply-To: <4F9CFB7F.4010207@aon.at>
References: <CAKLmikOLbh20g3j4UcKbBjhmvKsoXB9A0jHTR75NZLtuWBCtCQ@mail.gmail.com>
	<4F9CFB7F.4010207@aon.at>
From: Guido Iribarren <guidoiribarren@buenosaireslibre.org>
Date: Sun, 29 Apr 2012 11:29:30 -0300
Message-ID: <CAHD-aqKXJva8nYeWhxVcJW1LSay1WVnMhGAS7hSCoAQ=H2TtUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [B.A.T.M.A.N.] Batman with Ubiquiti SDK
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

On Sun, Apr 29, 2012 at 5:27 AM, fboehm <fboehm@aon.at> wrote:
> Hi Mitar,
>
> what Ubiquiti products are you using? Because they have the older
> 802.11a/b/g based product series and the newer 802.11n based with their
> proprietary Airmax wireless drivers. I am asking because the Airmax products
> have been upgraded to kernel 2.6.32 recently.

Indeed,

XM.v5.3# uname -a
Linux hostname 2.6.15-5.2 #1 Fri Jan 14 14:43:07 EET 2011 mips unknown

XM.v5.5# uname -a
Linux hostname 2.6.32.54 #1 Fri Apr 6 14:56:27 EEST 2012 mips unknown

(run on two nano loco m900, the latter with latest firmware)
