Return-Path: <fboehm@aon.at>
References: <CAA_JP8UAMyYUrKx0nYEhRyRTM2jObS2qFwaAmN=BwD298c93Jg@mail.gmail.com>
 <f2f7a980-c7c0-8b71-a4f7-4a4c7501f3d5@aon.at>
 <CAA_JP8WHB+SbkFWc3CCqY_tyPPq57X+hbHUH2bni62qqiSvnYg@mail.gmail.com>
 <1a42289f-d68a-e883-ecf9-d284c5c4376a@aon.at>
 <20170211064100.GB29718@otheros>
From: fboehm <fboehm@aon.at>
Message-ID: <05a26616-f73b-7b43-3cc1-6088e399b8bc@aon.at>
Date: Sat, 11 Feb 2017 12:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <20170211064100.GB29718@otheros>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [B.A.T.M.A.N.] how to hand ptp links and still access radio
 management interfaces
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

Am 2017-02-11 um 07:41 schrieb Linus Lüssing:
> On Fri, Feb 10, 2017 at 09:50:32AM +0100, fboehm wrote:
>> Because the Airfiber isn't aware of Batman header and can't
>> process such network traffic.
>
> Hm, why is that? The Airfiber can surely forward ethernet frames,
> can't it?
>
> Been using a pair of Ubiquiti NanoBridges with their stock
> firmware in WDS-bridging mode to forward batman-adv frames
> successfully in the past.
>
> Regards, Linus
>
True. But I think my information has to be seen in context to the 
initial thread topic: "access radio management interface of Airfiber".

That means if you manage Airfiber via a separate management VLAN, then 
this management-VLAN-Interface is unaware of batman header.

The capability of Airfiber to forward/bridge Ethernet frames with an 
embedded Batman header remains unaffected of this.

I Hope this clarifies the misunderstanding.

Franz
