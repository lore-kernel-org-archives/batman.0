Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Tue, 30 Nov 2010 18:26:58 +0100
References: <mailman.14.1290812292.944.b.a.t.m.a.n@lists.open-mesh.org>
	<AANLkTikZJn5T7gEc_REH_vyEwhKhTcsqLRdq8tX0OdF8@mail.gmail.com>
	<AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
In-Reply-To: <AANLkTinFgQ+Z4OsvyHTMNhy11=SrEz0Xu+YU2iZcdcwZ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201011301826.58467.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] BATMAN routing
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


Hi,

> The idea is to prioritize recently received OGM's thus giving them
> more weight for the routing decisions. This is because they give a
> precise indication of the status of current situation of the link.
> BATMAN algorithm currently counts the number of received OGM's in a
> current sliding window and the link with the most OGM's becomes the
> best next-hop towards a that destination. A lot can happen within a
> second in an ad hoc wireless network. if a lot of OGM's where recorded
> at the beginning of the window range and less towards the end which be
> that the link was better at the beginning not at the end of the
> sliding window (current). This could be selected as the best as
> opposed to the one that recorded a lot of OGM's towards the end but
> less in total. e.g. suppose you have sliding window of 10, link 1
> records [1111100000]= 5 and link 2 [0000001111] = 4. link 1 will be
> chosen and as it stands the current best would have been link 2.
> The proposed concept prioritizes the recently received OGM's by giving
> them more weight. Thus we want to add the indexes of which an OGM was
> received in that interval. from the example above we would have link
> 1+2+3+4+5+6= 21 and link 2 7+8+9+10 = 34.

your idea makes perfect sense. As a next step we want to split the OGM packet 
into 2 distinct types to increase efficiency. We are heavily discussing your 
concept in our IRC channel. You should drop in if you have the time or attend 
the discussion next weekend.

Cheers,
Marek
