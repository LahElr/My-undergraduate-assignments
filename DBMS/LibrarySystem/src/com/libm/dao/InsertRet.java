package com.libm.dao;

public class InsertRet {
	
	private boolean done;
	private int id;
	public InsertRet(boolean done,int id)
	{
		this.done=done;
		this.id=id;
	}
	public boolean getDone()
	{
		return this.done;
	}
	public int getID()
	{
		return this.id;
	}

}
