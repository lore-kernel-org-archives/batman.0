Return-Path: <andrew@lunn.ch>
Date: Sun, 9 May 2010 09:08:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20100509070835.GA20977@lunn.ch>
References: <201005091117.05627.lindner_marek@yahoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201005091117.05627.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] sysfs abi documentation
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

On Sun, May 09, 2010 at 11:17:04AM +0800, Marek Lindner wrote:
> 
> Hi,
> 
> Greg asked us to provide an ABI documentation for the files creates
> in the sysfs tree. Since I am respsonsible for the sysfs stuff, I
> felt it was my turn to draft something. Please check the attachments
> and let me know whether you think we can send it or not.

> What:           /sys/class/net/<mesh_iface>/mesh/originators
> Date:           May 2010
> Contact:        Marek Lindner <lindner_marek@yahoo.de>
> Description:
>                 Displays the table of all batman nodes (in range) and
>                 the link quality towards them. Each line contains the
>                 following values:
>                   1 - originator
>                   2 - TQ (transmit quality) value of originator
>                   3 - best next hop towards originator
>                   4 - outgoing iface to reach best next hop
>                   5 - list of alternative best next hops

Hi Marek

This is something i already said in private, but i think it is going
to be a problem.

From Documentation/filesystems/sysfs.txt

  Attributes
  ~~~~~~~~~~

  Attributes can be exported for kobjects in the form of regular files in
  the filesystem. Sysfs forwards file I/O operations to methods defined
  for the attributes, providing a means to read and write kernel
  attributes.

  Attributes should be ASCII text files, preferably with only one value
  per file. It is noted that it may not be efficient to contain only one
  value per file, so it is socially acceptable to express an array of
  values of the same type. 

  Mixing types, expressing multiple lines of data, and doing fancy
  formatting of data is heavily frowned upon. Doing these things may get
  you publically humiliated and your code rewritten without notice. 

I expect that we have a problem here. My guess is some of these files
are going to have to move back into proc. Use sysfs for configuration,
where only single values are needed, and put all the tables of
originators, HNA etc back in proc where fancy formatting of data is
not frowned upon.

	Andrew

