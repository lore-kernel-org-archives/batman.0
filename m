Message-Id: <3575E16D-DC85-4D31-A75E-C285F22A5B88@lo-res.org>
From: "L. Aaron Kaplan" <aaron@lo-res.org>
In-Reply-To: <4313f3060904300843ra2f7a71o37f39780a797cfd2@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Thu, 30 Apr 2009 18:27:45 +0200
References: <4313f3060904300843ra2f7a71o37f39780a797cfd2@mail.gmail.com>
Subject: Re: [B.A.T.M.A.N.] times wrapper
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
Cc: Henning Rogge <hrogge@googlemail.com>


On Apr 30, 2009, at 5:43 PM, Nathan Wharton wrote:

> When I first started meshing, I used olsrd.  There was a problem on
> our platform that caused olsrd packets to stop going out after the
> board had been up about 5 minutes.  The outage lasted about 40
> seconds, then came back.  It turns out that there is a problem with
> the times() call that will return -1 for the 4096 jiffies before wrap

FYI / maybe it helps BATMAN:

that has been fixed in olsrd in a more portable way in the meantime.

> around.  This caused no apparent change in time during that duration,
> so no packets were sent.  Also, for some reason on our platform,
> times() starts out about 5 minutes before wrap around.
>
> I found a work around elsewhere (and I leave credit in the patch) for
> some other software that was failing every 400 something days.  I
> applied this to olsrd, and the problem went away.
>
yes, we had some looong discussions about this on the lists.
It is really not easy to use times() in a OS/HW independant way.
One way is to check if there is an overrun in times().
That is how me and Sven-Ola fixed it.
Henning provided a more general/cleaner solution which can even  
survive if the clock goes backwards (sometimes happens on Xen  
machines! you wont believe it) or jumps badly. This has been tested  
with turning the time of the clock backwards etc.

Please also feel free to compare against the olsrd code in case that  
helps / in case you are interested.

the man page for times() says that it is deprecated.


One more thing for Nathan:

your comment in the patch
(+       /*
+        * times(2) really returns an unsigned value ...
+        *
+        * We don't check to see if we got back the error value (-1),  
because
+        * the only possibility for an error would be if the address of
+        * dummy_tms_struct was invalid.  Since it's a
+        * compiler-generated address, we assume that errors are  
impossible.
+        * And, unfortunately, it is quite possible for the correct  
return
+        * from times(2) to be exactly (clock_t)-1.  Sigh...
+        *
+        */

)

is only partly correct.
It really depends on the OS that you compile on.
Some OSes actually treat the return value as signed, some as unsigned.  
You can compare the different manpages for the different OSes.
But -1 is the problem after all, agreed.



*Sigh* when does Marek learn how to code proper C ;-))
^^^ --- just teasing, don't take it seriously.



> When I switched to batman, I saw that times() is used in it as well,
> so I made the patch attached.  So, if anyone sees packets fail to come
> from batman for 40 seconds, they might need this.
> <001-times.patch>_______________________________________________
> B.A.T.M.A.N mailing list
> B.A.T.M.A.N@open-mesh.net
> https://lists.open-mesh.net/mm/listinfo/b.a.t.m.a.n

