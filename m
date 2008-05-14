From: Marek Lindner <lindner_marek@yahoo.de>
Subject: Re: [B.A.T.M.A.N.] 0.3 final <-> quagga
Date: Thu, 15 May 2008 02:52:44 +0800
References: <51B22798-78A8-4425-BAEA-530297B1518A@cslab.ece.ntua.gr>
	<77182109-977E-4598-BD0B-ED38BCED2D68@cslab.ece.ntua.gr>
	<E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
In-Reply-To: <E2361084-04EE-46FD-A64C-631DE73E21AB@cslab.ece.ntua.gr>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9TzKIYmbhxjq+8Y"
Message-Id: <200805150252.45068.lindner_marek@yahoo.de>
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

--Boundary-00=_9TzKIYmbhxjq+8Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



> I created a new batquagga version (0.2) that does exactly that and even
> when removing the "sleep" and "kill" commands from restore_defaults(),
> it works fine.

Unfortunately, it does not cover all the cases. I attached the test shell 
script I used. Without the sleep & kill it does not die ...


> The arguments patch or some other form of passing arguments is essential
> for using the policy-routing-script to redistribute routes from other
> protocols...

As I said: Your idea is excellent - we just looked for an easy way to find a 
suitable solution for all sort of cases. The latest revision (1066) contains 
a method to forward the given arguments. You can use it like this:

batmand --policy-routing-script "test.sh one two three" eth0:bat

or even

batmand --policy-routing-script "test.sh \"one two three\"" eth0:bat

Greetings,
Marek

--Boundary-00=_9TzKIYmbhxjq+8Y
Content-Type: application/x-shellscript;
  name="test.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="test.sh"

#!/bin/sh

echo "start: $0" > /tmp/test.log

#trap 'got_signal' 2

#got_signal()
#{
#  echo "Caught SIGINT ..." >> /tmp/test.log
#}


for var in $*
do
	echo "$var" >> /tmp/test.log
done

while true
 do
     read bla
     echo "bla: $bla" >> /tmp/test.log
 done
 
--Boundary-00=_9TzKIYmbhxjq+8Y--
