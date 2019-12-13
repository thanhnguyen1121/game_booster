package com.example.gamebotter.Entity;

public class ImageDetail {
    String file;
    Boolean lock;
    boolean isDow;

    public ImageDetail(String file, Boolean lock, Boolean isDow) {
        this.file = file;
        this.lock = lock;
        this.isDow = isDow;
    }

    public boolean isDow() {
        return isDow;
    }

    public void setDow(boolean dow) {
        isDow = dow;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    public Boolean islock() {
        return lock;
    }

    public void setlock(Boolean lock) {
        this.lock = lock;
    }

    @Override
    public String toString() {
        return "{" +
                "file='" + file + '\'' +
                ", lock='" + lock + '\'' +
                '}';
    }
}
