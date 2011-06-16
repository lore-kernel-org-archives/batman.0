Return-Path: <lindner_marek@yahoo.de>
From: Marek Lindner <lindner_marek@yahoo.de>
Date: Thu, 16 Jun 2011 12:40:56 +0200
References: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
In-Reply-To: <BANLkTi=HCdWDjTQER8uOP48RW-XsZ6ehaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201106161240.57198.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] tangentially driver related question on
	broadcasts with batman-adv
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

On Thursday, June 16, 2011 12:04:41 AM David Beberman wrote:
> I did up the OGM rate, 100 msec and even 10 msec just to experiment.
> This actually seemed to reduce the next-hop decisions, based on the
> batctl ping results.

Did you disable aggregation while using these short intervals ?


> My next step is to getting into the transmit control flow in the WLAN
> device drivers for each piece of
> hardware and see if I can hard code the transmit data rate for
> broadcast packets.  Usually there is
> a control header for each transmit frame sent to the
> hardware/firmware.  Finding it, and understanding it
> without documentation is a challenge I've been hoping to avoid.

The linux wireless list (http://linuxwireless.org/en/developers/MailingLists) 
might be a more suitable place to discuss this kind of topic. 

Regards,
Marek
