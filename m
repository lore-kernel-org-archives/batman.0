Message-Id: <E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
In-Reply-To: <77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Wed, 14 May 2008 16:51:16 +0300
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<200805081812.33117.lindner_marek@yahoo.de>
	<CB4F1B6A-15D9-4CFD-BA29-4B6AC6F72596@cslab.ece.ntua.gr>
	<200805131634.20052.lindner_marek@yahoo.de>
	<77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
Reply-To: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n@open-mesh.net>
List-Id: The list for a Better Approach To Mobile Ad-hoc Networking
	<b.a.t.m.a.n.open-mesh.net>
List-Unsubscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=unsubscribe>
List-Archive: <http://list.open-mesh.net/pipermail/b.a.t.m.a.n>
List-Post: <mailto:b.a.t.m.a.n@open-mesh.net>
List-Help: <mailto:b.a.t.m.a.n-request@open-mesh.net?subject=help>
List-Subscribe: <https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n>,
	<mailto:b.a.t.m.a.n-request@open-mesh.net?subject=subscribe>
To: The list for a Better Approach To Mobile Ad-hoc Networking <b.a.t.m.a.n@open-mesh.net>


On May 13, 2008, at 12:14 PM, Antony Chazapis wrote:

>
> On May 13, 2008, at 11:34 AM, Marek Lindner wrote:
>>
>
>> I did some testing with a script which just prints the commands and  
>> I noticed
>> that the script can't execute those commands because it dies too  
>> quickly via
>> SIGINT or SIGTERM. Therefore the latest revision (1065) ignores these
>> signals. Apart from that we have a little sync problem. Batman  
>> kills its
>> child after sending all the commands via the pipe. At that moment  
>> the child
>> may still be busy with processing these commands. We have to find  
>> an elegant
>> way to communicate that the child finished its last job. The latest  
>> revision
>> waits another 3 seconds which is far from being perfect ...
>>

I've checked out the latest revision and have seen the problem you  
mention.
I think that waiting and then killing the process is not needed. If  
you just
close the pipe, the other end should notice that there is an EOF at  
stdin and die.
I created a new batquagga version (0.2) that does exactly that and even
when removing the "sleep" and "kill" commands from restore_defaults(),  
it works fine.

Moreover, batquagga-0.2 has no signal handlers for SIGKILL and SIGINT.
They are not needed anymore. Also, the "retain routes" option was  
removed
(no sense at this point, and no way to properly distinguish between  
delete routes
that happen at shutdown vs. delete routes that would normally occur).

>>
>> PS: Your addtional script arguments patch is an interesting idea.  
>> We are
>> checking on that because it might have some side effects.
>>


The arguments patch or some other form of passing arguments is essential
for using the policy-routing-script to redistribute routes from other  
protocols...

Antony

