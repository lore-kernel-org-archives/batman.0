From: Sven Eckelmann <sven.eckelmann@gmx.de>
Subject: Re: [B.A.T.M.A.N.] Batman gateway lock ups
Date: Wed, 10 Sep 2008 00:45:07 +0200
References: <5635aa0d0809050801k1c5f0bd5wa366574efedd910f@mail.gmail.com>
	<200809082318.54082.sven.eckelmann@gmx.de>
	<20080909112647.GA747@pandem0nium>
In-Reply-To: <20080909112647.GA747@pandem0nium>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_+xvxIecvdDdCaGW"
Message-Id: <200809100045.18090.sven.eckelmann@gmx.de>
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

--Boundary-00=_+xvxIecvdDdCaGW
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Tuesday 09 September 2008 13:26:47 Simon Wunderlich wrote:
> Hey Sven,
>
> thanks for you analysis!!
>
> [...]
>
> Mhm, as far as i looked into the issue, there are the following
> points where free_client_list is accessed:
> [...]
> So it seems there should be no concurrency without user interaction
> (module or batman shutdown).
> But i don't have a good idea yet where the problem comes from  ... :/
Yes, the idea of the race condition was stupid. So what is the real problem? 
Maybe a compiler bug? Let's check the assembler stuff:

The stuff around list_del in get_ip_addr:
     a90: lw	a0,4(s0) /* a0 gets our prev pointer */
     a94: lw	v1,0(s0) /* v1 gets our next pointer */
     a98: lui	v0,0x10  /* load 0x100100 in v0 */
     a9c: ori	v0,v0,0x100
     aa0: lw	s1,8(s0) /* load pointer to gw_client in s1 */
     aa4: sw	v1,0(a0) /* store our next pointer in the next pointer of prev
                          ****crash**** because 0x200200 or 0x0 was in our
                          next pointer - why do we have a poisened next
                          pointer when we are probably the first entry of the
                          list -> is the list not correctly initialised or
                          aren't we added correctly? */
     aa8: sw	v0,0(s0) /* store poison in next pointer */
     aac: lui	v0,0x20  /* load 0x200200 in v0 */
     ab0: ori	v0,v0,0x200
     ab4: sw	a0,4(v1) /* store our prev pointer in in the prev pointer of next 
*/


The initialisation of the list is done in init_module. prev and next should be 
set to the list address. So let's search for it:

    /* "zero" means here the position were our module was loaded to. */
    1374: lui	a1,0x0    /* set a1 to "zero" */
    1378: addiu	v1,a1,36 /* 36 is the position of the structure
                              free_client_list, so we set v1 to it */
    137c: lui	a0,0x0    /* set a0 to "zero" */
    1380: sw	v0,28(a0) /* store pointer to wp_hash */
    1384: sw	v1,36(a1) /* store free_client_list.next as free_client_list */
    1388: sw	v1,4(v1)  /* store free_client_list.prev as free_client_list */


So this looks good too. So when we have a entry, we must have added it 
somewhere. Lets take a look at packet_recv_thread again where the list_add is

    /* v0 and v1 holds pointer to new allocated struct */
    /* a3 holds "zero" - like t0 */
    9a8: sw	s1,8(v0) /* store pointer to client_data in new data buffer */
    9ac: lw	v0,36(a3) /* v0 gets free_client_list.next -> lets call it
                           next_element */
    /* shouldn't be another instruction between load and usage of the
       register? - like a nop */
    9b0: sw	v0,0(v1) /* store next_element in tmp_entry.list.next */
    9b4: sw	v1,4(v0) /* store pointer to tmp_entry next_element.prev */
    9b8: sw	v1,36(a3) /* store pointer to tmp_entry in freeclient_list.next  
*/
    9bc: j	9d4 <cleanup_module+0x524>
    9c0: sw	t0,4(v1) /* saves freeclient_list in tmp_entry.prev << if this
                          would not be executed in parallel, we would get
                          wrong data here, but because we are using mips it
                          must be executed */

So I cannot see anything special - only these two instructions. Maybe we 
should create a version with debug output after list_add with next and prev 
pointer of tmp_entry and free_client_list. The same with entry before calling 
list_del in get_ip_addr. This should be compiled for the nightwing and send to 
Outback Dingo so he can test it and send the kernel log after a crash to us. 
The problem is that I added some printks, checked the resulting output and 
noticed that this changed the output (so the interesting parts aren't 
there anymore).
So if it will run without problems and prints some "use free client from list" 
in the kernel log then we should have fixed it by resorting some instructions. 
If not... we should try to find it by using the extra debugging output.
If it runs without problems, please remove the printks around the list_add and 
if it still runs and prints some "use free client from list" now... do it the 
other way around (keep the printks around list_add and remove it before 
list_del).

...just my ideas to find the problem.

Best regards
	Sven Eckelmann

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjG/HsACgkQqQGwKVlMoDv6fACg90wX35fyHR13/Dh/nBvrKM4C
euwAn03zpb+HqWccdjcf7Z7SotWd+1s0
=pwTz
-----END PGP SIGNATURE-----

--Boundary-00=_+xvxIecvdDdCaGW
Content-Type: text/x-patch; charset="iso-8859-15"; name="batgat_test.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="batgat_test.patch"

--- a/batman/linux/modules/gateway.c
+++ b/batman/linux/modules/gateway.c
@@ -385,7 +385,11 @@ static int packet_recv_thread(void *data)
 						tmp_entry = kmalloc(sizeof(struct free_client_data), GFP_KERNEL);
 						if(tmp_entry != NULL) {
 							tmp_entry->gw_client = client_data;
+							printk("list_add_b; tmp_entry pointers (%p, %p)\n", tmp_entry->list.prev, tmp_entry->list.next);
+							printk("list_add_b; free_client_list pointers (%p, %p)\n", free_client_list.prev, free_client_list.next);
 							list_add(&tmp_entry->list,&free_client_list);
+							printk("list_add_a; tmp_entry pointers (%p, %p)\n", tmp_entry->list.prev, tmp_entry->list.next);
+							printk("list_add_a; free_client_list pointers (%p, %p)\n", free_client_list.prev, free_client_list.next);
 						} else
 							DBG("can't add free gw_client to free list");
 
@@ -642,6 +646,7 @@ static struct gw_client *get_ip_addr(struct sockaddr_in *client_addr)
 	list_for_each_entry_safe(entry, next, &free_client_list, list) {
 		DBG("use free client from list");
 		gw_client = entry->gw_client;
+		printk("free client; entry pointers (%p, %p)\n", entry->list.prev, entry->list.next);
 		list_del(&entry->list);
 		break;
 	}

--Boundary-00=_+xvxIecvdDdCaGW--
