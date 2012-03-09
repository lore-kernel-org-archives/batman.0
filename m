Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 9 Mar 2012 23:40:28 +0800
References: <201203070156.51341.lindner_marek@yahoo.de>
	<201203092236.51812.lindner_marek@yahoo.de>
	<CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
In-Reply-To: <CANjd3ndFCA8LqJt1Un70zjv_OV3ye3kqiOoab1vCh73qd33+Pg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201203092340.28265.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [Battlemesh]  Diversity in BATMAN
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
To: b.a.t.m.a.n@lists.open-mesh.org, Battle of the Mesh Mailing List <battlemesh@ml.ninux.org>

On Friday, March 09, 2012 23:25:03 Benjamin Henrion wrote:
> TQ is based on packet-loss only, so it is doomed to fail to detect
> fast interfaces.
> 
> With such metric, you don't make any difference between a 56K
> telephone line and a 10Ge NIC.
> 
> If you 10Ge has 5pc packet loss and your 56K line has 0pc, your TQ
> will be prefer the 56k link.

Absolute correct assessment. 

I'd like to add that batman was designed to work most efficiently in 
environments with packet loss. The main target was/is wireless and not 
environments without packet loss. However, we do noticed the desire to use 
batman in other environments too and are working on improving batman to 
satisfy this demand. I'm not sure we will ever be as efficient as routing 
protocols that were designed for "stable" environments only.

Regards,
Marek
