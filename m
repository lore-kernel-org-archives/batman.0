From: Marek Lindner <lindner_marek@yahoo.de>
Date: Sat, 21 Mar 2009 16:34:46 +0800
References: <49C40762.3050109@java-system.com>
	<200903210917.54806.lindner_marek@yahoo.de>
	<49C49C1A.6050100@java-system.com>
In-Reply-To: <49C49C1A.6050100@java-system.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903211634.46493.lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] What do you think of this result?
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

On Saturday 21 March 2009 15:49:46 marco tozzini wrote:
>  From batman debug output it seems batman station has a good view one to
> each other, but working on this systems is very annoying:
> ssh terminal has a wobbling response to commands
>
> Is this the behavior I shall expect from a good working mesh system?

Please keep in mind what batman is doing to obtain these results: It 
broadcasts packets and receives broadcasts. From that it tries to give an 
estimation about the networks status and the link conditions. Obviously, you 
can't derive latency or bandwidth throughput from this information base. 

Lets look at your fping test: Usually batman broadcasts are sent once a 
second. While rebroadcasting a jitter is applied to reduce the probability of 
collisions with other batman packets. When you run fping on 192.168.2.200/30 
you will generate traffic that has a high probability of collisions which will 
lead to different test results.

If you compare test mechanisms make sure they run under the same conditions 
otherwise it does not make sense to draw conclusions from it. The batman TQ 
value tells you how batman sees the link at this specific time - nothing more 
or less. This is an approximation of the reality. If you have ideas how to 
improve it let us know. Meanwhile, we can try to help getting your wifi up to 
speed (see antonios mail).  :-)

Regards,
Marek

