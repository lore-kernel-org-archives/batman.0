Mime-Version: 1.0 (Apple Message framework v752.2)
In-Reply-To: <200805150252.45068.lindner_marek@yahoo.de>
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
	<E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
	<200805150252.45068.lindner_marek@yahoo.de>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CB6D3CEE-C8C6-4047-AED4-AAF9F90EB2CF@cslab.ece.ntua.gr>
Content-Transfer-Encoding: 7bit
From: Antony Chazapis <chazapis@cslab.ece.ntua.gr>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Thu, 15 May 2008 03:01:57 +0300
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


On May 14, 2008, at 9:52 PM, Marek Lindner wrote:

>
>
>> I created a new batquagga version (0.2) that does exactly that and  
>> even
>> when removing the "sleep" and "kill" commands from restore_defaults 
>> (),
>> it works fine.
>
> Unfortunately, it does not cover all the cases. I attached the test  
> shell
> script I used. Without the sleep & kill it does not die ...
>

This is because you use a "while true" loop.

Try instead:

while read bla
do
      echo "bla: $bla"
done

>
>> The arguments patch or some other form of passing arguments is  
>> essential
>> for using the policy-routing-script to redistribute routes from other
>> protocols...
>
> As I said: Your idea is excellent - we just looked for an easy way  
> to find a
> suitable solution for all sort of cases. The latest revision (1066)  
> contains
> a method to forward the given arguments. You can use it like this:
>
> batmand --policy-routing-script "test.sh one two three" eth0:bat
>
> or even
>
> batmand --policy-routing-script "test.sh \"one two three\"" eth0:bat
>

Even simpler... Much better.

> Greetings,
> Marek
> <test.sh>
> _______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://list.open-mesh.net/mm/listinfo/b.a.t.m.a.n

