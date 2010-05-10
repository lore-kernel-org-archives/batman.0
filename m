Return-Path: <ordex@ritirata.org>
Date: Mon, 10 May 2010 13:57:55 +0200
From: Antonio Quartulli <ordex@ritirata.org>
Message-ID: <20100510115755.GA2510@ritirata.org>
References: <20100508170755.GA27599@ritirata.org>
	<201005100147.59454.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005100147.59454.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Blocking OGMs from a node for testing purpose
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

On lun, mag 10, 2010 at 01:47:58 +0800, Marek Lindner wrote:
> 
> Hi,
> 
> welcome on our list!  :-)

Thank you! :)

> 
> > To do this, first of all, I should block OGMs from a particular station.
> > I tried with ebtables in order to block all the packets with source MACa
> > (where MACa is the MAC address of the station I would prevent to
> > communicate with me), but I failed.
> > 
> > Does anyone know a working way to do what I described before?
> 
> I think it would be easier to help you, if described in more detail what 
> exactly you tried so far and why it was not successful. Please give us all the 
> settings & commands involved otherwise we have to guess what is going on.

Ok, I'm going to list all the commands I used.
First of all, I'm using the svn version of batman-adv, in order to be up to date.
The topology, actually, is a simple adhoc net between two hosts.

What I did is: inserting the module, activating the if and adding the phy if to bat0:
# insmod batman-adv.ko
# ifconfig bat0 up
# batctl if add  wlan0

Then I tried to block any kind of packets from a known mac (say MACa).

# ebtables -A INPUT -s MACa -j DROP

After this I checked with "battctl o" if I was still able to see the other host, and even waiting a few minutes, the host was still in the list.

What am I missing?
I tried also using the FORWARD chain of ebtables, and also adding more constraints on the filer, but it didn't help.

I hope to have explained it clearly.

Regards
Antonio
