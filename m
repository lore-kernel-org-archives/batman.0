From: Marek Lindner <lindner_marek@yahoo.de>
Date: Fri, 20 Mar 2009 20:47:30 +0800
References: <3ebdcf0a0903180743q3968e6a0wd480347cf70a50ff@mail.gmail.com>
	<200903191055.53458.lindner_marek@yahoo.de>
	<3ebdcf0a0903190638p583bababq7891e21413b4f4e@mail.gmail.com>
In-Reply-To: <3ebdcf0a0903190638p583bababq7891e21413b4f4e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903202047.30861.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] Problem with B.A.T.M.A.N. 0.3.1 rv1206
	(compatibility version 5)
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://lists.open-mesh.net/mm/options/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://lists.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>

On Thursday 19 March 2009 21:38:14 Max wrote:
> Now I'm able to ping every originator in the network. The problem is
> derived from some iptables filters that stop the ping. Executing the
> following command I remove the filters solving the problem:

Glad to hear that.


> When I launch the daemon in normal mode, using the command "batmand ath0",
> no error is displayed but no OGMs is observed to be travelling in the
> network using Wireshark. The only message displayed is:
> "Interface activated: ath0
> Using interface ath0 with address 10.0.0.1 and broadcast address
> 10.255.255.255"

Could you please run 
batmand -c -d 4
after you started the daemon ? This command will make batman start a "client" 
that connects to the running daemon that outputs error messages. Feel free to 
share these messages with us.  :-)


> And finally another question...
> Is it normal to observe 3 different processes named batmand using the shell
> command ps?

Batman uses threads to parallelize certain tasks (basically 2 threads). Older 
kernel versions / different thread implementations don't offer "real" threads 
but use processes instead. Usually, they create a control process that syncs 
the other "threads" (processes in this case), hence 2 + 1 processes in "ps".

Regards,
Marek

