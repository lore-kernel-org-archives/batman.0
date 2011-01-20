Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 20 Jan 2011 12:01:14 +0100
References: <1295518649-25141-1-git-send-email-lindner_marek@yahoo.de>
	<201101201157.25991.sven@narfation.org>
In-Reply-To: <201101201157.25991.sven@narfation.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <201101201201.15645.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] [PATCH] batman-adv: update compat version
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

On Thursday 20 January 2011 11:57:23 Sven Eckelmann wrote:
> On Thursday 20 January 2011 11:17:29 Marek Lindner wrote:
> > The compatibility version has to be updated as the OGM packet
> > received a new field (gw_flags).
> 
> Why that? Compat 12 was the version with gw flags.
>  http://www.open-mesh.org/wiki/BatmanAdvCompatVersion

Cool - I knew there was an overview table somewhere but I did not manage to 
find it.  :-)

As the table states 2010.2.0 got version 13 but trunk & next are on 12. I made 
a diff between the packet.h files and saw the gateway flags, therefore I proposed 
to increase the version number to 14. Should the next release contain a 
version smaller than the previous release ?

Regards,
Marek
