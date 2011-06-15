Return-Path: <fboehm@aon.at>
Message-ID: <4DF907DB.2070802@aon.at>
Date: Wed, 15 Jun 2011 21:28:27 +0200
From: fboehm <fboehm@aon.at>
MIME-Version: 1.0
References: <4DF90276.8050701@aon.at>
	<201106152122.30123.lindner_marek@yahoo.de>
In-Reply-To: <201106152122.30123.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [B.A.T.M.A.N.] Linux bridge-code for something like BATMAN
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

Am 2011-06-15 21:22, schrieb Marek Lindner:
> Hi,
>
>> I know bridging is not routing but I was thinking since some time if it
>> is possible to modify the linux bridge-code for forwarding layer2
>> packets according to the rules of some routing algorithm. This means the
>> bridge would not learn mac addresses from ARP protocol any longer but
>> from a daemon. The result would be a layer2 mesh routing like BATMAN does.
> if you want something like BATMAN why not simply using BATMAN ? Or you are
> trying to understand the difference between standard bridging and BATMAN ?
>
> Regards,
> Marek
>

unfortunately I am stuck with an older kernel where I can't use BATMAN. 
And everytime I am dealing with linux bridge configuration this idea 
comes into my mind.

At the moment it's just an idea but before starting some experiments I 
would like to get some feedback.

Regards,
Franz
