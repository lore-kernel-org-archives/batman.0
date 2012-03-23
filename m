Return-Path: <andrew@lunn.ch>
Date: Fri, 23 Mar 2012 07:50:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20120323065044.GD5662@lunn.ch>
References: <201203222250.31309.lindner_marek@yahoo.de>
	<1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1332453075-27999-1-git-send-email-lindner_marek@yahoo.de>
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
Cc: Marek Lindner <lindner_marek@yahoo.de>

> --- a/packet.h
> +++ b/packet.h
> @@ -33,7 +33,8 @@ enum bat_packettype {
>  	BAT_UNICAST_FRAG	= 0x06,
>  	BAT_TT_QUERY		= 0x07,
>  	BAT_ROAM_ADV		= 0x08,
> -	BAT_UNICAST_4ADDR	= 0x09
> +	BAT_UNICAST_4ADDR	= 0x09,
> +	BAT_V_ELP		= 0x10
>  };

Hi Marek

I guess you are not on the ARM linux kernel list. A couple of months
ago, Rusty had a rant about the last entry in such structures should
always have a , even though its optional. As part of the ARM cleanup
work he had to append a new entry to many board files, and found it
very error prone. Sometime you forget to add the , to the line before,
and then the compiler spits out a compile error. So since then i've
got into the habit of always having a , on the last entry.

     Andrew
