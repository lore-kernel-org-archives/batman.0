Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 5 Apr 2012 23:21:06 +0300
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
	<20120323065044.GD5662@lunn.ch>
In-Reply-To: <20120323065044.GD5662@lunn.ch>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201204052321.07234.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [RFC 1/5] batman-adv: ELP - adding basic
	infrastructure
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

On Friday, March 23, 2012 08:50:44 Andrew Lunn wrote:
> I guess you are not on the ARM linux kernel list. A couple of months
> ago, Rusty had a rant about the last entry in such structures should
> always have a , even though its optional. As part of the ARM cleanup
> work he had to append a new entry to many board files, and found it
> very error prone. Sometime you forget to add the , to the line before,
> and then the compiler spits out a compile error. So since then i've
> got into the habit of always having a , on the last entry.

No, I don't follow the ARM list. If we wanted the comma to be there we should 
change the entire module. At the moment we never put the comma after the last 
item.

Regards,
Marek
